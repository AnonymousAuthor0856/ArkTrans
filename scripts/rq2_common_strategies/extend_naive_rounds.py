#!/usr/bin/env python3
"""Extend the plain (no-image) naive iteration run by repair rounds 6..cap.

Faithful continuation of the round-5 extension (extend_naive_iter5.py):
- resume state per file = latest round-K code + FULL round-K error list,
  i.e. exactly what a --max-iterations cap+1 run would hold after round K;
- repair prompts are identical to rounds 1-5 verbatim (numbered error list
  + typescript fence, REPAIR_SYSTEM unchanged), provider qwen (qwen3.6-27b,
  temperature 0, enable_thinking off);
- compile = real hvigorw assembleHap on the minimal_hos template;
- base and -r5 dirs are NEVER modified; rounds 6+ artifacts go to sibling
  <base>-r10/{fid}/ with {fid}_iterK.ets and {fid}_iterK_errors.txt;
  interrupted runs resume (highest existing round is reloaded).

Usage:
  python extend_naive_rounds.py --lang kjc --cap 10            # all failing ids
  python extend_naive_rounds.py --lang kjc --cap 10 --ids 002  # smoke
"""

import argparse
import json
import os
import re
import shutil
import statistics
import subprocess
import sys
import tempfile
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

import os as _os
from pathlib import Path as _P
from dotenv import load_dotenv as _ld
_ld(_P(__file__).resolve().parents[1] / ".env")
ROOT = _P(_os.environ.get("ARKTRANS_ROOT", str(_P(__file__).resolve().parents[2])))
sys.path.insert(0, str(ROOT / "scripts" / "rq4_arktrans"))

from arktrans_agent import ArkTransAgent  # noqa: E402  (loads .env)

HVIGORW = _os.environ.get("HVIGORW", "hvigorw")
JAVA_HOME = _os.environ.get("JAVA_HOME", "")
TEMPLATE = _P(_os.environ.get("MINIMAL_HOS_TEMPLATE",
               str(_P(__file__).resolve().parents[1] / "evaluate" / "minimal_hos")))

REPAIR_SYSTEM = ("You are an expert ArkTS developer. Fix the compilation "
                 "errors in the provided code. Output ONLY the fixed ArkTS "
                 "code, no explanations.")

BASES = {
    "kjc": ROOT / "目前补完的实验/qwen/iteration_baseline/qwen-kjc-iteration",
    "swift": ROOT / "目前补完的实验/qwen/iteration_baseline/qwen-swift-iteration",
}

_print_lock = threading.Lock()

def hvigor_compile(code: str):
    """Real hvigor compile; returns (ok, errors) with '[code] Line N: msg' lines."""
    with tempfile.TemporaryDirectory() as tmpdir:
        project = Path(tmpdir) / "test"
        shutil.copytree(TEMPLATE, project, dirs_exist_ok=True,
                        ignore=shutil.ignore_patterns('.idea', '.git', 'build', '.hvigor'))
        (project / "entry" / "src" / "main" / "ets" / "pages" / "Index.ets").write_text(code)
        env = os.environ.copy()
        env["JAVA_HOME"] = JAVA_HOME
        env["PATH"] = f"{JAVA_HOME}/bin:{Path(HVIGORW).parent}:{env.get('PATH', '')}"
        try:
            r = subprocess.run([HVIGORW, "--no-daemon", "assembleHap"], cwd=str(project),
                               capture_output=True, text=True, timeout=240, env=env)
        except subprocess.TimeoutExpired:
            return False, ["TIMEOUT"]
        out = r.stdout + r.stderr
        out = re.sub(r'\x1b\[[0-9;]*m', '', out)
        out = re.sub(r'\[\d+m', '', out)
        if r.returncode == 0:
            return True, []
        errors = []
        for code_id, msg, line, _col in re.findall(
                r'\d+\s*ERROR:\s*(\d+)\s*ArkTS\s*Compiler\s*Error\s*\n'
                r'Error\s*Message:\s*(.+?)At\s*File:\s*[^:]+:(\d+):(\d+)',
                out, re.DOTALL):
            errors.append(f"[{code_id}] Line {line}: {' '.join(msg.split())}")
        return False, errors

def state_of(base: Path, out_base: Path, fid: str):
    r5_dir = Path(str(base) + "-r5") / fid
    if (r5_dir / f"{fid}_iter5.ets").exists():
        code = (r5_dir / f"{fid}_iter5.ets").read_text(encoding="utf-8")
        errs = [ln for ln in (r5_dir / f"{fid}_iter5_errors.txt").read_text(
            encoding="utf-8").splitlines() if ln.strip()]
        k = 5
    else:
        return None
    for kk in range(6, 11):
        f_ets = out_base / fid / f"{fid}_iter{kk}.ets"
        if f_ets.exists():
            code = f_ets.read_text(encoding="utf-8")
            errs = [ln for ln in (out_base / fid / f"{fid}_iter{kk}_errors.txt").read_text(
                encoding="utf-8").splitlines() if ln.strip()]
            k = kk
        else:
            break
    return code, errs, k

def failing_ids(base: Path):
    r5 = Path(str(base) + "-r5")
    ids = []
    for d in sorted(r5.glob("[0-9][0-9][0-9]")):
        ef = d / f"{d.name}_iter5_errors.txt"
        if ef.exists() and ef.read_text(encoding="utf-8").strip():
            ids.append(d.name)
    return ids

def process_one(agent: ArkTransAgent, base: Path, out_base: Path, fid: str, cap: int):
    st = state_of(base, out_base, fid)
    code, errors, k0 = st
    total_tokens = 0
    rescued_at = None
    rounds_meta = []
    for k in range(k0 + 1, cap + 1):
        error_text = "\n".join(f"{i + 1}. {e}" for i, e in enumerate(errors))
        repair_user = ("The following ArkTS code has compilation errors. Fix them "
                       "and output the corrected code.\n\n**Compiler Errors:**\n"
                       f"{error_text}\n\n**Code:**\n```typescript\n{code}\n```")
        t0 = time.time()
        new_code, usage, raw = agent.call_llm_verbose(REPAIR_SYSTEM, repair_user)
        total_tokens += usage.get("total_tokens", 0)
        kept_previous = not new_code.strip()
        final_code = code if kept_previous else new_code
        ok, new_errors = hvigor_compile(final_code)
        dst = out_base / fid
        dst.mkdir(parents=True, exist_ok=True)
        (dst / f"{fid}_iter{k}.ets").write_text(final_code, encoding="utf-8")
        (dst / f"{fid}_iter{k}_errors.txt").write_text("\n".join(new_errors), encoding="utf-8")
        (dst / f"{fid}_iter{k}_trace.json").write_text(json.dumps({
            "file_id": fid, "round": k, "compiles": ok, "kept_previous": kept_previous,
            "tokens": usage.get("total_tokens", 0), "errors": len(new_errors),
            "latency_ms": round((time.time() - t0) * 1000)}, ensure_ascii=False, indent=1))
        rounds_meta.append({"round": k, "compiles": ok, "errors": len(new_errors),
                            "kept_previous": kept_previous})
        with _print_lock:
            print(f"  {fid} r{k}: {'PASS' if ok else f'FAIL({len(new_errors)})'}"
                  f"{'+kept' if kept_previous else ''} tokens={usage.get('total_tokens', 0)}",
                  flush=True)
        if ok:
            rescued_at = k
            break
        code, errors = final_code, new_errors
    return fid, rescued_at, total_tokens, rounds_meta

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lang", choices=["kjc", "swift"], required=True)
    ap.add_argument("--cap", type=int, default=10)
    ap.add_argument("--ids", nargs="*", default=None)
    ap.add_argument("--workers", type=int, default=4)
    args = ap.parse_args()

    base = BASES[args.lang]
    out_base = Path(str(base) + "-r10")
    out_base.mkdir(exist_ok=True)
    ids = args.ids or failing_ids(base)
    print(f"[{args.lang}] failing-at-r5: {len(ids)} ids, cap={args.cap} -> {out_base}", flush=True)

    summary_path = out_base / "_summary.json"
    summary = {"results": {}}
    if summary_path.exists():
        summary = json.load(open(summary_path))
    agent = ArkTransAgent(provider="qwen", enable_compiler_feedback=False)

    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        futs = {ex.submit(process_one, agent, base, out_base, fid, args.cap): fid
                for fid in ids}
        for fut in as_completed(futs):
            fid, rescued_at, tokens, rounds_meta = fut.result()
            summary["results"][fid] = {"rescued_at": rescued_at, "tokens": tokens,
                                       "rounds": rounds_meta}
            done = [r for v in summary["results"].values() for r in v.get("rounds", [])]
            summary["n"] = len(summary["results"])
            summary["rescued"] = sum(1 for v in summary["results"].values()
                                     if v.get("rescued_at"))
            summary_path.write_text(json.dumps(summary, ensure_ascii=False, indent=1),
                                    encoding="utf-8")
    toks = [v["tokens"] for v in summary["results"].values()]
    print(f"===== {args.lang} r6-r{args.cap} done: rescued "
          f"{summary.get('rescued', 0)}/{summary.get('n', 0)}, "
          f"tokens_mean={statistics.mean(toks) if toks else 0:.0f}", flush=True)

if __name__ == "__main__":
    main()
