#!/usr/bin/env python3
"""RQ1/RQ2 direct-translation baselines.

Protocols (verbatim-matched to existing experiment families):
  direct          : system + source fence, single call        (= qwen-kjc iter0)
  direct+image    : same + the sample's GT screenshot         (--with-image)
  direct+iterate  : naive repair loop, prompts verbatim from
                    qwen-kjc-iteration trace calls[1+]        (--max-iter N)
  (+image & iterate combine freely)
"""

import argparse
import base64
import json
import re
import statistics
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "rq4_arktrans"))
from framework import ArkTransFramework  # noqa: E402

import os as _os
from pathlib import Path as _P
from dotenv import load_dotenv as _ld
_ld(_P(__file__).resolve().parents[2] / ".env")
ROOT = _P(_os.environ.get("ARKTRANS_ROOT", str(_P(__file__).resolve().parents[3])))

REPAIR_SYSTEM = ("You are an expert ArkTS developer. Fix the compilation errors in the "
                 "provided code. Output ONLY the fixed ArkTS code, no explanations.")

def extract_code(raw: str) -> str:
    raw = raw.strip()
    m = re.search(r"```(?:typescript|arkts|ts)?\s*\n(.*?)```", raw, re.DOTALL)
    if m:
        return m.group(1).strip()
    return raw

def img_data_uri(path: Path) -> str:
    b64 = base64.b64encode(path.read_bytes()).decode()
    return f"data:image/png;base64,{b64}"

def main():
    ap = argparse.ArgumentParser(description="RQ1/RQ2 direct baselines (plain / +image / +iterate)")
    ap.add_argument("input", help="Directory of .kt/.swift files")
    ap.add_argument("-o", "--output", required=True)
    ap.add_argument("--lang", choices=["kotlin", "swift"], default="kotlin")
    ap.add_argument("--provider", choices=["deepseek", "glm", "qwen"], default="deepseek")
    ap.add_argument("--model", default="")
    ap.add_argument("--with-image", action="store_true",
                    help="attach the sample's GT screenshot (suc/<lang>_img/<id>.png)")
    ap.add_argument("--max-iter", type=int, default=0,
                    help="naive compile-feedback repair rounds after the first call (0=off)")
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--ids", default="", help="Comma-separated file ids, e.g. 001,005")
    ap.add_argument("--img-dir", default="",
                    help="override reference-image directory (default: suc/<lang>_img)")
    args = ap.parse_args()

    import os
    from dotenv import load_dotenv
    load_dotenv(Path(__file__).parent / ".env")
    from openai import OpenAI

    if not args.model:
        args.model = {"glm": "glm-5.2", "qwen": "qwen3.6-27b"}.get(args.provider, "deepseek-v4-pro")
    if args.provider == "glm":
        client = OpenAI(api_key=os.getenv("GLM_API_KEY"), base_url="https://open.bigmodel.cn/api/paas/v4")
        extra = {"thinking": {"type": "disabled"}}
    elif args.provider == "qwen":
        client = OpenAI(api_key=os.getenv("QWEN_API_KEY"), base_url=os.getenv("QWEN_BASE_URL"))
        extra = {"enable_thinking": False}
    else:
        client = OpenAI(api_key=os.getenv("DEEPSEEK_API_KEY"), base_url=os.getenv("DEEPSEEK_BASE_URL"))
        extra = {"reasoning_effort": "none"}

    dialect = "SwiftUI" if args.lang == "swift" else "Kotlin Compose"
    system = (f"You are an expert ArkTS developer. Convert this {dialect} code to "
              f"compilable ArkTS code with a screenshot. Output compilable ArkTS code only.")

    skill = ArkTransFramework()  # compile_check only
    out_root = Path(args.output)
    files = sorted(Path(args.input).glob("*.kt" if args.lang == "kotlin" else "*.swift"))
    if args.ids:
        wanted = {x.strip() for x in args.ids.split(",")}
        files = [f for f in files if f.stem in wanted]
    if args.limit:
        files = files[: args.limit]

    def call(messages, max_tokens=16384):
        r = client.chat.completions.create(
            model=args.model, messages=messages, temperature=0.0,
            max_tokens=max_tokens, extra_body=extra)
        return r.choices[0].message.content or "", (r.usage.total_tokens if r.usage else 0)

    rows = []
    for f in files:
        out = out_root / f.stem
        out.mkdir(parents=True, exist_ok=True)
        t0 = time.time()
        img_dir = Path(args.img_dir) if args.img_dir else ROOT / "suc" / ("swift_img" if args.lang == "swift" else "kotlin_img")
        img_path = img_dir / f"{f.stem}.png"

        text_part = (f"```{args.lang}\n{f.read_text(encoding='utf-8')}\n```"
                     if not args.with_image else
                     "The attached image is the reference screenshot of the UI rendered by the "
                     "source code below. Use it to reproduce the layout, colors, spacing, and "
                     f"text content.\n\n```{args.lang}\n{f.read_text(encoding='utf-8')}\n```")
        if args.with_image and img_path.exists():
            content = [{"type": "text", "text": text_part},
                       {"type": "image_url", "image_url": {"url": img_data_uri(img_path)}}]
        else:
            content = text_part
        messages = [{"role": "system", "content": system}, {"role": "user", "content": content}]

        trace = {"file_id": f.stem, "model": args.model, "with_image": args.with_image,
                 "max_iter": args.max_iter, "rounds": []}
        try:
            code, tokens = call(messages)
        except Exception as e:
            print(f"{f.name}: LLM 调用失败 {str(e)[:120]}")
            trace["error"] = str(e)[:300]
            (out / "trace.json").write_text(json.dumps(trace, ensure_ascii=False))
            rows.append({"file_id": f.stem, "compiles": False, "tokens": 0})
            continue
        total_tokens = tokens

        ets = out / "Index.ets"
        ets.write_text(extract_code(code), encoding="utf-8")
        ok, errors = skill.compile_check(str(ets))
        trace["rounds"].append({"round": 0, "tokens": tokens, "errors": len(errors), "compiles": ok})

        for it in range(1, args.max_iter + 1):
            if ok:
                break
            err_text = "\n".join(f"{i+1}. {e}" for i, e in enumerate(errors))
            repair_user = (f"The following ArkTS code has compilation errors. Fix them and "
                           f"output the corrected code.\n\n**Compiler Errors:**\n{err_text}\n\n"
                           f"**Code:**\n```typescript\n{ets.read_text(encoding='utf-8')}\n```")
            try:
                fixed, rtok = call([{"role": "system", "content": REPAIR_SYSTEM},
                                    {"role": "user", "content": repair_user}])
            except Exception as e:
                trace["rounds"].append({"round": it, "error": str(e)[:120]})
                break
            total_tokens += rtok
            ets.write_text(extract_code(fixed), encoding="utf-8")
            ok, errors = skill.compile_check(str(ets))
            trace["rounds"].append({"round": it, "tokens": rtok, "errors": len(errors), "compiles": ok})

        trace.update({"compiles": ok, "errors": len(errors), "tokens": total_tokens,
                      "latency_ms": round((time.time() - t0) * 1000)})
        (out / "trace.json").write_text(json.dumps(trace, indent=2, ensure_ascii=False), encoding="utf-8")
        rows.append({"file_id": f.stem, "compiles": ok, "tokens": total_tokens,
                     "errors": len(errors), "rounds": len(trace["rounds"])})
        print(f"{f.name}: {'PASS' if ok else f'{len(errors)} errors'} | {total_tokens} tokens"
              + (f" | {len(trace['rounds'])-1} repair" if args.max_iter else ""))

    n_ok = sum(r["compiles"] for r in rows)
    toks = [r["tokens"] for r in rows if r["tokens"]]
    summary = {"model": args.model, "lang": args.lang, "provider": args.provider,
               "with_image": args.with_image, "max_iter": args.max_iter,
               "method": f"direct{'(+image)' if args.with_image else ''}"
                         f"{'(+naive-iteration)' if args.max_iter else ''}",
               "pass": n_ok, "n": len(rows), "compile_rate": n_ok / max(len(rows), 1),
               "tokens_mean": round(statistics.mean(toks)) if toks else 0, "rows": rows}
    (out_root / "_summary.json").write_text(json.dumps(summary, indent=2, ensure_ascii=False), encoding="utf-8")
    print(f"\n==== {summary['method']} {args.model} {args.lang}: {n_ok}/{len(rows)} "
          f"({100 * n_ok / max(len(rows), 1):.0f}%) ====")

if __name__ == "__main__":
    main()
