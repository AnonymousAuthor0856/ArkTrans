#!/usr/bin/env python3
"""Extend the plain (no-image) naive iteration run by ONE repair round (round 5).

Faithful continuation of experiments/raw/qwen-{kjc,swift}-iteration:
- resume state = round-4 code (NNN_iter4.ets) + FULL round-4 error list
  (NNN_iter4_errors.txt), i.e. exactly what a --max-iterations 6 run would
  hold after round 4;
- repair prompts are compare_baseline.run_direct_baseline's strings verbatim
  (numbered error list + typescript fence), provider qwen (qwen3.6-27b,
  temperature 0, enable_thinking off) -- identical to rounds 1-4;
- compile = real hvigorw assembleHap on the minimal_hos template (verified
  200/200 identical to the original traces' error counts).

Provenance: base group dirs are NEVER modified; artifacts go to sibling
dirs  <base>-r5/{fid}/  with {fid}_iter5.ets, {fid}_iter5_errors.txt and a
per-run _summary.json (pass counts, tokens). Interrupted runs resume (the
summary is rewritten after every file).

Usage:
  python extend_naive_iter5.py --lang kjc           # all failing ids
  python extend_naive_iter5.py --lang kjc --ids 001 002  # smoke
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

def failing_ids(base: Path):
    return sorted(d.name for d in (base / "iterations" / "direct").glob("[0-9][0-9][0-9]")
                  if (d / f"{d.name}_iter4_errors.txt").exists())

def process_one(agent: ArkTransAgent, base: Path, out_base: Path, fid: str):
    src_dir = base / "iterations" / "direct" / fid
    code = (src_dir / f"{fid}_iter4.ets").read_text(encoding="utf-8")
    errors = [ln for ln in (src_dir / f"{fid}_iter4_errors.txt").read_text(
        encoding="utf-8").splitlines() if ln.strip()]
    error_text = "\n".join(f"{i + 1}. {e}" for i, e in enumerate(errors))
    repair_user = ("The following ArkTS code has compilation errors. Fix them "
                   "and output the corrected code.\n\n**Compiler Errors:**\n"
                   f"{error_text}\n\n**Code:**\n```typescript\n{code}\n```")
    t0 = time.time()
    new_code, usage, raw = agent.call_llm_verbose(REPAIR_SYSTEM, repair_user)
    kept_previous = not new_code.strip()
    final_code = code if kept_previous else new_code
    ok, new_errors = hvigor_compile(final_code)
    dst = out_base / fid
    dst.mkdir(parents=True, exist_ok=True)
    (dst / f"{fid}_iter5.ets").write_text(final_code, encoding="utf-8")
    (dst / f"{fid}_iter5_errors.txt").write_text("\n".join(new_errors), encoding="utf-8")
    (dst / "_trace.json").write_text(json.dumps({
        "file_id": fid, "round": 5, "compiles": ok, "kept_previous": kept_previous,
        "tokens": usage.get("total_tokens", 0),
        "latency_ms": round((time.time() - t0) * 1000),
        "raw_response_chars": len(raw)}, ensure_ascii=False, indent=1))
    with _print_lock:
        print(f"  {fid}: {'PASS' if ok else f'FAIL({len(new_errors)})'}"
              f"{'+kept' if kept_previous else ''} tokens={usage.get('total_tokens', 0)}",
              flush=True)
    return fid, ok, usage.get("total_tokens", 0)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lang", choices=["kjc", "swift"], required=True)
    ap.add_argument("--ids", nargs="*", default=None)
    ap.add_argument("--workers", type=int, default=4)
    args = ap.parse_args()

    base = BASES[args.lang]
    out_base = Path(str(base) + "-r5")
    out_base.mkdir(exist_ok=True)
    ids = args.ids or failing_ids(base)
    # resume: skip ids already done
    done = set()
    summary_path = out_base / "_summary.json"
    if summary_path.exists():
        done = set(json.load(open(summary_path)).get("results", {}).keys())
    todo = [i for i in ids if i not in done]
    print(f"[{args.lang}] failing-at-r4: {len(ids)}, todo: {len(todo)} -> {out_base}")

    summary = {"results": {}}
    if summary_path.exists():
        summary = json.load(open(summary_path))
    agent = ArkTransAgent(provider="qwen", enable_compiler_feedback=False)

    def agent_for_thread():
        return agent  # OpenAI client is thread-safe

    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        futs = {ex.submit(process_one, agent_for_thread(), base, out_base, fid): fid
                for fid in todo}
        for fut in as_completed(futs):
            fid, ok, tokens = fut.result()
            summary["results"][fid] = {"pass": ok, "tokens": tokens}
            npass = sum(1 for v in summary["results"].values() if v["pass"])
            summary["n"] = len(summary["results"])
            summary["pass"] = npass
            summary_path.write_text(json.dumps(summary, ensure_ascii=False, indent=1))
    toks = [v["tokens"] for v in summary["results"].values()]
    print(f"===== {args.lang} r5 done: {summary['pass']}/{summary['n']} pass, "
          f"tokens_mean={statistics.mean(toks) if toks else 0:.0f}")

if __name__ == "__main__":
    main()
