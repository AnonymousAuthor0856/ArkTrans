#!/usr/bin/env python3
"""Extend failed cases of an iteration experiment with repair rounds 6..cap
(iteration-round sensitivity: does the pass rate keep growing past 5 rounds?).

Supported groups (--group):
  rq4  results/rq4_method/qwen-final-{lang}          compact pipeline
       (skeleton+image+naive repair); resume state = repair5.code.ets,
       repair protocol = compact_skill.repair_naive (verbatim)
  rq2  results/rq2_visual/direct-image-iter-{lang}   direct+image+naive
       iteration (direct_translate.py); resume state = Index.ets, repair
       protocol = direct_translate.py's call verbatim (same system/user,
       extract_code, no unusable-output stop)

Provenance rules:
- Base group dirs are NEVER modified. Failed case dirs are copied next to
  them as <name>-r{cap}/ and extended there.
- The resumed state (round-5 code + fresh hvigor compile errors of it) is
  exactly the loop state a --max-repair cap run would hold after round 5;
  repair prompts are identical to rounds 1-5 (temperature 0).
- Per-round checkpointing: trace.json is rewritten after every round, so an
  interrupted batch resumes where it stopped (re-run with the same --cap).

Usage:
  python extend_rounds.py --group rq2 --cap 10              # all failed ids
  python extend_rounds.py --group rq2 --lang kotlin --ids 001  # subset/smoke
"""

import argparse
import json
import shutil
import sys
import time
from pathlib import Path

import os as _os
from pathlib import Path as _P
from dotenv import load_dotenv as _ld
_ld(_P(__file__).resolve().parents[1] / ".env")
ROOT = _P(_os.environ.get("ARKTRANS_ROOT", str(_P(__file__).resolve().parents[2])))
sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "rq4_arktrans"))
sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "rq1_zero_shot" / "llm_direct"))

from compact_skill import CompactSkill  # noqa: E402
from direct_translate import REPAIR_SYSTEM as DIRECT_REPAIR_SYSTEM  # noqa: E402
from direct_translate import extract_code as direct_extract_code  # noqa: E402

GROUPS = {
    "rq4": {
        "src": lambda lang: ROOT / "results" / "rq4_method" / f"qwen-final-{lang}",
        "out_root": ROOT / "results" / "rq4_method_extended",
        "out_name": f"qwen-final-{{lang}}-r{{cap}}",
        "mode": "compact",
    },
    "rq2": {
        "src": lambda lang: ROOT / "results" / "rq2_visual" / f"direct-image-iter-{lang}",
        "out_root": ROOT / "results" / "rq2_visual",
        "out_name": f"direct-image-iter-{{lang}}-r{{cap}}",
        "mode": "direct",
    },
}

STOP_PASSED = "passed"
STOP_CAP = "cap_reached"
STOP_NO_OUTPUT = "no_usable_output"
STOP_LLM_ERROR = "llm_error"

class DirectRepairer:
    """Verbatim direct_translate.py repair call (qwen), for the rq2 group."""

    def __init__(self):
        import os
        from dotenv import load_dotenv
        from openai import OpenAI
        load_dotenv(Path(__file__).parent / ".env")
        self.model = os.getenv("QWEN_MODEL", "qwen3.6-27b")
        self.client = OpenAI(api_key=os.getenv("QWEN_API_KEY"),
                             base_url=os.getenv("QWEN_BASE_URL"))
        self.extra = {"enable_thinking": False}

    def repair(self, code: str, errors: list, round_no: int,
               round_dir: Path):
        """Returns (new_code, tokens, stop). stop=True means the LLM call
        failed twice (the original protocol breaks the loop on that)."""
        err_text = "\n".join(f"{i+1}. {e}" for i, e in enumerate(errors))
        user = (f"The following ArkTS code has compilation errors. Fix them and "
                f"output the corrected code.\n\n**Compiler Errors:**\n{err_text}\n\n"
                f"**Code:**\n```typescript\n{code}\n```")
        (round_dir / f"repair{round_no}.prompt.txt").write_text(
            f"=== system ===\n{DIRECT_REPAIR_SYSTEM}\n=== user ===\n{user}",
            encoding="utf-8")
        raw, tok = "", 0
        for attempt in (1, 2):
            try:
                r = self.client.chat.completions.create(
                    model=self.model,
                    messages=[{"role": "system", "content": DIRECT_REPAIR_SYSTEM},
                              {"role": "user", "content": user}],
                    temperature=0.0, max_tokens=16384, extra_body=self.extra)
                raw = r.choices[0].message.content or ""
                tok = r.usage.total_tokens if r.usage else 0
                break
            except Exception as e:
                print(f"  [Repair] LLM call failed (attempt {attempt}): {e}")
                if attempt == 2:
                    return None, 0, True
                time.sleep(30)
        (round_dir / f"repair{round_no}.answer.txt").write_text(raw, encoding="utf-8")
        return direct_extract_code(raw), tok, False

def failed_cases(group: str, lang: str) -> list:
    base = GROUPS[group]["src"](lang)
    cases = []
    for t in sorted(base.glob("*/trace.json")):
        d = json.loads(t.read_text())
        if d.get("compiles"):
            continue
        last = max(r["round"] for r in d["rounds"] if "round" in r)
        if last != 5:
            # early-break failure: a longer run would have stopped at the same
            # round, nothing to extend
            print(f"[skip] {lang}/{d['file_id']}: stopped at round {last}, not extendable")
            continue
        cases.append((d["file_id"], t.parent))
    return cases

def load_or_init(dst: Path, src_case: Path, cap: int) -> dict:
    """Return the extension trace; copy the case dir and seed round-5 state
    on first run, or pick up an interrupted extension."""
    tjson = dst / "trace.json"
    if tjson.exists():
        return json.loads(tjson.read_text())

    shutil.copytree(src_case, dst)
    d = json.loads(tjson.read_text())
    d["compiles_r5"] = d["compiles"]
    d["extension"] = {
        "base_run": str(src_case),
        "cap": cap,
        "rounds_added": [],
        "stop_reason": None,
        "total_tokens_ext": 0,
        "latency_ms_ext": 0.0,
        "note": ("repair rounds 6..%d appended; same repair prompt as rounds 1-5 "
                 "(temp 0), state resumed from the round-5 code" % cap),
    }
    tjson.write_text(json.dumps(d, indent=2, ensure_ascii=False))
    return d

def resume_code_file(dst: Path, mode: str, last: int) -> Path:
    """Loop-state code at the end of round `last`: our own repair artifact if
    the extension already advanced, else the base run's round-5 state."""
    cand = dst / f"repair{last}.code.ets"
    if cand.exists():
        return cand
    return dst / "Index.ets"  # rq2 base run keeps the loop state in Index.ets

def extend_case(skill, repairer, group: str, lang: str, file_id: str,
                src_case: Path, cap: int) -> dict:
    g = GROUPS[group]
    dst = g["out_root"] / g["out_name"].format(lang=lang, cap=cap) / file_id
    d = load_or_init(dst, src_case, cap)
    ext = d["extension"]
    trace = d
    last = max(r["round"] for r in trace["rounds"] if "round" in r)

    if ext["stop_reason"] and not (ext["stop_reason"] == STOP_CAP
                                   and last < cap and not trace["compiles"]):
        return {"file_id": file_id, "status": "done",
                "stop": ext["stop_reason"], "compiles": trace["compiles"]}
    ext["cap"] = cap

    code_file = resume_code_file(dst, g["mode"], last)
    if not code_file.exists():
        ext["stop_reason"] = f"missing {code_file.name}"
        (dst / "trace.json").write_text(json.dumps(trace, indent=2, ensure_ascii=False))
        return {"file_id": file_id, "status": "error", "stop": ext["stop_reason"],
                "compiles": trace["compiles"]}
    code = code_file.read_text(encoding="utf-8")

    t0 = time.time()
    print(f"[{lang}/{file_id}] resume from round {last}: compiling {code_file.name} ...")
    (dst / "_state.ets").write_text(code, encoding="utf-8")
    ok, errors = skill.compile_check(str(dst / "_state.ets"))
    (dst / "_state.ets").unlink()
    if ok:
        # should not happen (case failed originally), but guard anyway
        trace["rounds"].append({"round": last + 1, "tokens": 0, "errors": 0,
                                "compiles": True, "note": "state already compiled"})
        trace["compiles"] = True
        ext["stop_reason"] = STOP_PASSED
        (dst / "trace.json").write_text(json.dumps(trace, indent=2, ensure_ascii=False))
        return {"file_id": file_id, "status": "done", "stop": STOP_PASSED,
                "compiles": True}

    r5 = [r for r in trace["rounds"] if r.get("round") == last][-1]
    orig_errs = r5.get("errors")
    if orig_errs is not None and abs(orig_errs - len(errors)) > max(3, 0.2 * orig_errs):
        print(f"  [warn] fresh compile gives {len(errors)} errors, "
              f"original round-{last} trace said {orig_errs} (env drift?) - using fresh")

    it = last + 1
    while it <= cap:
        if ok:
            break
        print(f"  repair round {it}/{cap} ({len(errors)} errors) ...")
        (dst / f"repair{it}.errors.txt").write_text("\n".join(errors), encoding="utf-8")

        stop = False
        if g["mode"] == "compact":
            fixed, rusage = None, {}
            for attempt in (1, 2):  # one retry on transient API errors only
                try:
                    fixed, rusage = skill.repair_naive(code, errors, it, round_dir=dst)
                    break
                except Exception as e:
                    print(f"  [Repair] LLM call failed (attempt {attempt}): {e}")
                    if attempt == 2:
                        fixed = None
                    else:
                        time.sleep(30)
            r_tokens = rusage.get("total_tokens", 0)
            if fixed is None:
                print("      no usable repair output, stop")
                ext["stop_reason"] = STOP_NO_OUTPUT
                stop = True
        else:  # direct protocol: no unusable-output stop, only LLM errors stop
            fixed, r_tokens, stop = repairer.repair(code, errors, it, dst)
            if stop:
                print("      LLM error, stop")
                ext["stop_reason"] = STOP_LLM_ERROR
        if stop:
            break

        code = fixed
        (dst / f"repair{it}.code.ets").write_text(code, encoding="utf-8")
        (dst / "Index.ets").write_text(code, encoding="utf-8")
        ok, errors = skill.compile_check(str(dst / "Index.ets"))
        trace["rounds"].append({"round": it, "tokens": r_tokens,
                                "errors": len(errors), "compiles": ok})
        ext["rounds_added"].append(it)
        ext["total_tokens_ext"] += r_tokens
        trace["compiles"] = ok
        print(f"      -> {'OK' if ok else f'{len(errors)} errors'} "
              f"({r_tokens} tokens)")
        # per-round checkpoint
        ext["latency_ms_ext"] = (time.time() - t0) * 1000
        (dst / "trace.json").write_text(json.dumps(trace, indent=2, ensure_ascii=False))
        it += 1

    if ok:
        ext["stop_reason"] = STOP_PASSED
    elif ext["stop_reason"] is None:
        ext["stop_reason"] = STOP_CAP
    ext["latency_ms_ext"] = (time.time() - t0) * 1000
    (dst / "trace.json").write_text(json.dumps(trace, indent=2, ensure_ascii=False))
    return {"file_id": file_id, "status": "done", "stop": ext["stop_reason"],
            "compiles": trace["compiles"],
            "rounds_added": ext["rounds_added"]}

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--group", choices=list(GROUPS), default="rq4")
    ap.add_argument("--cap", type=int, default=10, help="last repair round (default 10)")
    ap.add_argument("--lang", choices=["kotlin", "swift", "both"], default="both")
    ap.add_argument("--ids", default="", help="comma-separated subset of file ids")
    args = ap.parse_args()

    g = GROUPS[args.group]
    langs = ["kotlin", "swift"] if args.lang == "both" else [args.lang]
    wanted = {x.strip() for x in args.ids.split(",") if x.strip()}

    skill = CompactSkill(provider="qwen")  # compile_check + compact repair
    repairer = DirectRepairer() if g["mode"] == "direct" else None
    g["out_root"].mkdir(parents=True, exist_ok=True)

    summary = {}
    for lang in langs:
        cases = failed_cases(args.group, lang)
        if wanted:
            cases = [c for c in cases if c[0] in wanted]
        print(f"\n==== [{args.group}] {lang}: {len(cases)} failed cases to extend "
              f"to round {args.cap} ====")
        rows = []
        for fid, src_case in cases:
            r = extend_case(skill, repairer, args.group, lang, fid, src_case, args.cap)
            rows.append(r)
            print(f"[{lang}] {fid}: stop={r['stop']} compiles={r['compiles']}")
        n_ok = sum(1 for r in rows if r["compiles"])
        base_pass = 100 - len(failed_cases(args.group, lang))
        print(f"\n==== [{args.group}] {lang} extension summary: {n_ok}/{len(rows)} now "
              f"compile (after up to {args.cap} repair rounds) ====")
        summary[lang] = {"n": len(rows), "now_compiles": n_ok,
                         "base_pass_r5": base_pass, "rows": rows}
        out_dir = g["out_root"] / g["out_name"].format(lang=lang, cap=args.cap)
        (out_dir / "_extend_summary.json").write_text(
            json.dumps(summary[lang], indent=2, ensure_ascii=False), encoding="utf-8")

    (g["out_root"] / f"_extend_summary_{args.group}_cap{args.cap}.json").write_text(
        json.dumps(summary, indent=2, ensure_ascii=False), encoding="utf-8")
    print(json.dumps({k: {kk: vv for kk, vv in v.items() if kk != "rows"}
                      for k, v in summary.items()}, indent=2))

if __name__ == "__main__":
    main()
