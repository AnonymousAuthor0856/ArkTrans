#!/usr/bin/env python3
"""
CompactSkill - the ArkTrans compact pipeline (two mechanisms).

Motivation (see COMPACT_PIPELINE.md / analysis_rq3/): naive direct+iterate
translation fails on small models because repair context drowns in repeated
compile errors (91% of round-4 errors had already survived earlier rounds)
and full-file rewrites keep re-breaking syntax (65% of all errors).

The pipeline is exactly two mechanisms (ablation-validated, results_ablation/):
  M1  skeleton guidance - tree-sitter parse -> metadata skeleton -> LLM fills
  M3  patch-mode repair - compiler errors + line-numbered code -> the model
      answers with FIX/INS/DEL line directives only; we splice deterministically

Everything else (error translation, free/deterministic fixes, safety guard)
was ablated to neutral-or-negative and removed. The 5-module variant lives in
attic/compact_skill_full.py for ablation reproduction.
"""

import json
import re
import sys
import time
from pathlib import Path

import os as _os
from pathlib import Path as _P
from dotenv import load_dotenv as _ld
_ld(_P(__file__).resolve().parents[1] / ".env")
ROOT = _P(_os.environ.get("ARKTRANS_ROOT", str(_P(__file__).resolve().parents[2])))
from typing import Dict, List, Optional, Tuple

from framework import ArkTransFramework, TranslationResult

MAX_ERRORS_IN_PROMPT = 8
# a chain-call line that lost its receiver would be invalid ArkTS, but the
# deterministic re-attach rule was part of the removed M4 module - not here
ERROR_R = re.compile(r"^\[(\d+)\] Line (\d+): (.*)$")

def trim_skeleton(skeleton: str) -> str:
    """Drop `// source:` lines (raw source snippets) - noise for small models."""
    return "\n".join(
        ln for ln in skeleton.splitlines() if not ln.strip().startswith("// source:")
    )

class CompactSkill(ArkTransFramework):
    """Two-mechanism pipeline: skeleton guidance + patch-mode repair loop."""

    def __init__(self, *args, patch_threshold: int = 4, with_image: bool = False,
                 use_skeleton: bool = True, repair_mode: str = "naive",
                 img_dir: Optional[str] = None, **kwargs):
        super().__init__(*args, **kwargs)
        self.patch_threshold = patch_threshold
        # attach the sample's GT screenshot to the fill prompt (visual prior)
        self.with_image = with_image
        # repair_mode: "naive" (DEFAULT, RQ2-style full-file rewrite with raw errors)
        #              "patch" (line-directive FIX/INS/DEL repair; better only when
        #                       first-round quality is low, e.g. no image)
        self.use_skeleton = use_skeleton
        self.repair_mode = repair_mode
        # reference screenshot dir; default = main benchmark suc/{lang}_img
        self.img_dir = Path(img_dir) if img_dir else None

    def find_ref_image(self, file_id: str, lang: str) -> Optional[Path]:
        img_dir = self.img_dir or (ROOT / "suc" / ("swift_img" if lang == "swift" else "kotlin_img"))
        for ext in (".png", ".jpg", ".jpeg"):
            p = img_dir / f"{file_id}{ext}"
            if p.exists():
                return p
        return img_dir / f"{file_id}.png"

    # -- M1 + LLM fill --------------------------------------------------------
    def step3_translate(self, ui_data: Dict, skeleton_code: str,
                        lang: str = "kotlin", source_text: str = "",
                        image_path: Optional[Path] = None) -> Tuple[str, Dict]:
        pl = self._get_pipeline()
        skeleton = trim_skeleton(skeleton_code)
        src_dialect = "SwiftUI" if lang == "swift" else "Kotlin Compose"

        if self.use_skeleton:
            core_block = f"""**UI Structure with Metadata:**
```typescript
{skeleton}
```"""
            system_head = f"Convert this ArkTS-style {src_dialect} UI skeleton to compilable ArkTS code."
            core_head = "**UI Structure with Metadata:**"
            core_body = f"```typescript\n{skeleton}\n```"
        else:
            # ablation: no skeleton - translate the raw source directly
            core_block = f"""**Source code ({src_dialect}):**
```{lang}
{source_text}
```"""
            system_head = f"Convert this {src_dialect} UI code to compilable ArkTS code."
            core_head = f"**Source code ({src_dialect}):**"
            core_body = f"```{lang}\n{source_text}\n```"

        system = f"""You are an expert ArkTS developer. {system_head}

Follow the code style and patterns shown in the example below:

{pl.ONE_SHOT_EXAMPLE}

Output compilable ArkTS code only."""

        img_hint = ""
        if self.with_image and image_path and Path(image_path).exists():
            img_hint = ("Use the attached reference screenshot to reproduce "
                        "layout, colors, spacing, and text content.\n\n")

        text_part = f"""{img_hint}{core_head}
{core_body}

Rules:
1. NO object literals without an interface; NO `any`; NO function-typed @State
2. Images: ONLY $r('app.media.startIcon') exists; any other resource name fails
3. Implement every child - do not simplify or omit

Output the complete ArkTS file only:"""

        if self.with_image and image_path and Path(image_path).exists():
            import base64
            b64 = base64.b64encode(Path(image_path).read_bytes()).decode()
            user: object = [{"type": "text", "text": text_part},
                            {"type": "image_url",
                             "image_url": {"url": f"data:image/png;base64,{b64}"}}]
        else:
            user = text_part

        code, usage, _ = self.call_llm_verbose(system, user)
        return code, usage

    # -- M3: patch-mode repair -------------------------------------------------
    def repair_compact(self, code: str, errors: List[str], skeleton: str,
                       round_no: int, round_dir: Optional[Path] = None) -> Tuple[Optional[str], Dict]:
        code_lines = code.splitlines()
        if not errors:
            return None, {}
        err_block = "\n".join(errors[:15])
        n_sites = min(len(errors), MAX_ERRORS_IN_PROMPT)
        patch_mode = n_sites <= self.patch_threshold

        system = """You are an ArkTS compiler-error repair engine. You fix ONLY the reported errors.
Hard rules:
- Valid ArkTS UI syntax only: no Kotlin (`fun`, `val`), no Swift (`some View`, `VStack`)
- Object literals need declared interfaces; no `any`
- Inside build() only UI calls / if / ForEach are allowed
- Return EXACTLY the requested format, no explanations."""

        skel_meta = "\n".join(
            ln for ln in (skeleton or "").splitlines()
            if ln.strip().startswith(("// ===", "// props:", "// modifier:"))
        )[:1500]

        if patch_mode:
            user = f"""The ArkTS file below has {n_sites} error sites. Fix them with minimal line edits.

**Errors:**
{err_block}

**Current code (line numbers are 1-based and CRITICAL):**
```
{chr(10).join(f"{i+1}| {ln}" for i, ln in enumerate(code_lines))}
```

Output format - one directive per line, nothing else (no explanations, no code fences):
FIX <line>: <complete replacement for that line>
INS <line>: <new line to insert BEFORE that line>
DEL <line>
Placement rules:
- interfaces/imports/type declarations live OUTSIDE the struct - add them with `INS 1: ...`
- one statement per FIX line; never squeeze several statements into one line
"""
        else:
            user = f"""Fix ALL these errors:

**Errors:**
{err_block}

**Reference skeleton metadata (intended structure):**
{skel_meta}

**Current code:**
```typescript
{code}
```

You may either:
A) Output patch lines only:  FIX <line_number>: <complete replacement line>
B) If damage is structural, output the complete corrected file in one ```typescript block.
"""

        try:
            answer, usage, _raw = self.call_llm_verbose(system, user)
        except Exception as e:
            print(f"    [Repair] LLM call failed: {e}")
            return None, {}

        if round_dir is not None:
            (round_dir / f"repair{round_no}.prompt.txt").write_text(
                f"=== system ===\n{system}\n=== user ===\n{user}", encoding="utf-8")
            (round_dir / f"repair{round_no}.answer.txt").write_text(answer, encoding="utf-8")

        patched = self._apply_patch(answer, code_lines)
        if patched is not None:
            return patched, usage or {}
        pl = self._get_pipeline()
        candidate = pl.extract_code(answer)
        if candidate and ("@Entry" in candidate or "@Component" in candidate):
            return candidate, usage or {}
        return None, usage or {}

    @staticmethod
    def _apply_patch(answer: str, code_lines: List[str]) -> Optional[str]:
        """Apply FIX/INS/DEL directives; returns None if the answer is not a patch.

        A FIX whose replacement is absurdly long is rejected - that is a full
        file crammed onto one line, splicing it would destroy the file.
        """
        directives = []
        for ln in answer.splitlines():
            m = re.match(r"\s*(FIX|INS)\s+(\d+)\s*:\s*(.*)$", ln)
            if m:
                if len(m.group(3)) > 400:
                    return None
                directives.append((m.group(1), int(m.group(2)), m.group(3)))
                continue
            m = re.match(r"\s*DEL\s+(\d+)\s*$", ln)
            if m:
                directives.append(("DEL", int(m.group(1)), None))
        if not directives:
            return None
        out = list(code_lines)
        applied = 0
        # apply bottom-up so line numbers stay valid across INS/DEL
        for kind, line_no, payload in sorted(directives, key=lambda d: -d[1]):
            if kind == "DEL" and 1 <= line_no <= len(out):
                del out[line_no - 1]
                applied += 1
            elif kind in ("FIX", "INS") and 1 <= line_no <= len(out):
                if kind == "FIX":
                    out[line_no - 1] = payload
                else:
                    out.insert(line_no - 1, payload)
                applied += 1
        if applied == 0:
            return None
        return "\n".join(out)

    # -- ablation: RQ2-style naive full-file rewrite repair (verbatim member protocol)
    def repair_naive(self, code: str, errors: List[str],
                     round_no: int, round_dir: Optional[Path] = None) -> Tuple[Optional[str], Dict]:
        if not errors:
            return None, {}
        err_text = "\n".join(f"{i+1}. {e}" for i, e in enumerate(errors))
        system = ("You are an expert ArkTS developer. Fix the compilation errors in the "
                  "provided code. Output ONLY the fixed ArkTS code, no explanations.")
        user = (f"The following ArkTS code has compilation errors. Fix them and output the "
                f"corrected code.\n\n**Compiler Errors:**\n{err_text}\n\n"
                f"**Code:**\n```typescript\n{code}\n```")
        try:
            answer, usage, _raw = self.call_llm_verbose(system, user)
        except Exception as e:
            print(f"    [Repair] LLM call failed: {e}")
            return None, {}
        if round_dir is not None:
            (round_dir / f"repair{round_no}.prompt.txt").write_text(
                f"=== system ===\n{system}\n=== user ===\n{user}", encoding="utf-8")
            (round_dir / f"repair{round_no}.answer.txt").write_text(answer, encoding="utf-8")
        pl = self._get_pipeline()
        candidate = pl.extract_code(answer)
        if candidate and ("@Entry" in candidate or "@Component" in candidate):
            return candidate, usage or {}
        return None, usage or {}

    # -- main loop --------------------------------------------------------------
    def run_compact(self, source_path: str, output_dir: str, lang: str = "kotlin") -> TranslationResult:
        start = time.time()
        source_path = Path(source_path)
        out = Path(output_dir)
        out.mkdir(parents=True, exist_ok=True)

        result = TranslationResult(
            file_id=source_path.stem, source_path=str(source_path),
            source_lang=lang, output_dir=str(out),
        )
        trace = {"file_id": result.file_id, "lang": lang, "provider": self.provider,
                 "model": self._get_model_config().get("model", ""), "rounds": []}

        # M1: deterministic parse + skeleton (skipped entirely in the -skeleton ablation)
        if self.use_skeleton:
            if lang == "swift":
                result.json_data = self.step1_parse_swift(str(source_path))
                if not result.json_data or "error" in result.json_data:
                    print("    parse failed")
                    return result
                result.skeleton_code = self.step2_skeleton_swift(result.json_data)
            else:
                result.json_data = self.step1_parse(str(source_path))
                if result.json_data is None:
                    return result
                result.skeleton_code = self.step2_skeleton(result.json_data)
            print(f"  [1-2] skeleton: {len(result.skeleton_code)} chars "
                  f"(trimmed: {len(trim_skeleton(result.skeleton_code))})")
        else:
            print("  [1-2] skeleton SKIPPED (-skeleton ablation: raw source)")

        # LLM fill
        print(f"  [3] LLM translate ({self.provider}" + (" +image" if self.with_image else "") + ")...")
        image_path = self.find_ref_image(result.file_id, lang) if self.with_image else None
        result.llm_raw_code, usage = self.step3_translate(
            result.json_data or {}, result.skeleton_code or "", lang=lang,
            source_text=source_path.read_text(encoding="utf-8"),
            image_path=image_path)
        result.token_usage = usage
        total_tokens = usage.get("total_tokens", 0)
        print(f"      {len(result.llm_raw_code)} chars, {total_tokens} tokens")

        code = result.llm_raw_code
        output_file = out / "Index.ets"
        output_file.write_text(code, encoding="utf-8")
        result.final_code = code

        ok, errors = self.compile_check(str(output_file))
        result.compiles, result.compile_errors = ok, errors
        trace["rounds"].append({"round": 0, "tokens": usage.get("total_tokens", 0),
                                "errors": len(errors), "compiles": ok})
        print(f"  [5] compile round 0: {'OK' if ok else f'{len(errors)} errors'}")

        # repair loop (patch mode or, for ablation, naive full-file rewrite)
        best = (len(errors) if not ok else 0, code, ok)
        for it in range(1, self.max_iterations + 1):
            if ok:
                break
            print(f"  [6] repair round {it}/{self.max_iterations} ({len(errors)} errors)...")
            (out / f"repair{it}.errors.txt").write_text(
                "\n".join(errors), encoding="utf-8")
            if self.repair_mode == "naive":
                fixed, rusage = self.repair_naive(code, errors, it, round_dir=out)
            else:
                fixed, rusage = self.repair_compact(
                    code, errors, result.skeleton_code, it, round_dir=out)
            if fixed is None:
                print("      no usable repair output, stop")
                break

            code = fixed
            (out / f"repair{it}.code.ets").write_text(code, encoding="utf-8")
            output_file.write_text(code, encoding="utf-8")
            ok, errors = self.compile_check(str(output_file))
            result.iteration_codes.append(fixed)
            total_tokens += rusage.get("total_tokens", 0)
            trace["rounds"].append({"round": it, "tokens": rusage.get("total_tokens", 0),
                                    "errors": len(errors), "compiles": ok})
            result.final_code = code
            result.num_iterations = it
            result.compiles, result.compile_errors = ok, errors
            print(f"      -> {'OK ✅' if ok else f'{len(errors)} errors'}")
            if not ok and len(errors) < best[0]:
                best = (len(errors), code, False)

        # keep the best-known code on disk even when it still fails
        if not result.compiles and best[1] is not None and best[1] != code:
            result.final_code = best[1]
            output_file.write_text(best[1], encoding="utf-8")
            result.compiles, result.compile_errors = best[2], [f"[best-effort] {best[0]} errors remain"]

        result.token_usage = {**result.token_usage,
                              "total_tokens": total_tokens,
                              "rounds": len(trace["rounds"])}
        trace["compiles"] = result.compiles
        trace["total_tokens"] = total_tokens
        trace["latency_ms"] = (time.time() - start) * 1000
        (out / "trace.json").write_text(
            json.dumps(trace, indent=2, ensure_ascii=False), encoding="utf-8")
        result.latency_ms = trace["latency_ms"]
        self.results.append(result)
        return result

def main():
    import argparse
    parser = argparse.ArgumentParser(description="ArkTrans compact pipeline (M1 skeleton + M3 patch mode)")
    parser.add_argument("input", help="Input .kt/.swift file or directory")
    parser.add_argument("-o", "--output", required=True)
    parser.add_argument("--provider", default="qwen")
    parser.add_argument("--lang", choices=["kotlin", "swift"], default="kotlin")
    parser.add_argument("--max-repair", type=int, default=5)
    parser.add_argument("--limit", type=int, default=0, help="Only first N files (0=all)")
    parser.add_argument("--ids", default="", help="Comma-separated file ids, e.g. 001,005")
    parser.add_argument("--with-image", action="store_true",
                        help="attach the sample's GT screenshot to the fill prompt")
    parser.add_argument("--no-skeleton", action="store_true",
                        help="ablation: skip parse/skeleton, fill from raw source")
    parser.add_argument("--img-dir", default="",
                        help="reference screenshot dir (default: suc/{lang}_img)")
    parser.add_argument("--patch-repair", action="store_true",
                        help="use line-directive patch repair instead of the default "
                             "naive full-file iteration")
    args = parser.parse_args()

    src = Path(args.input)
    files = sorted(src.glob("*.kt" if args.lang == "kotlin" else "*.swift")) if src.is_dir() else [src]
    if args.ids:
        wanted = {x.strip() for x in args.ids.split(",")}
        files = [f for f in files if f.stem in wanted]
    if args.limit:
        files = files[: args.limit]

    skill = CompactSkill(provider=args.provider, max_iterations=args.max_repair,
                         with_image=args.with_image,
                         use_skeleton=not args.no_skeleton,
                         repair_mode="patch" if args.patch_repair else "naive",
                         img_dir=args.img_dir or None)
    rows = []
    for f in files:
        print(f"\n=== {f.name} ===")
        out_dir = Path(args.output) / f.stem
        r = skill.run_compact(str(f), str(out_dir), lang=args.lang)
        rows.append(r.to_dict() | {"total_tokens": r.token_usage.get("total_tokens", 0)})
        print(f"  => compiles={r.compiles} iters={r.num_iterations} "
              f"tokens={r.token_usage.get('total_tokens', 0)}")

    n_ok = sum(1 for r in rows if r["compiles"])
    print(f"\n==== SUMMARY: {n_ok}/{len(rows)} compile "
          f"({100.0 * n_ok / max(len(rows), 1):.0f}%) ====")
    (Path(args.output) / "_summary.json").write_text(
        json.dumps({"pass": n_ok, "n": len(rows),
                    "compile_rate": n_ok / max(len(rows), 1), "rows": rows},
                   indent=2, ensure_ascii=False), encoding="utf-8")

if __name__ == "__main__":
    main()
