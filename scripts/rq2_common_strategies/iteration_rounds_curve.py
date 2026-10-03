#!/usr/bin/env python3
"""Iteration-round sensitivity curve (rounds 0..10) for the qwen iteration
experiments, merging each base run with its extend_rounds.py extension.

Groups:
  rq4  final method (skeleton+image+naive repair), results/rq4_method
  rq2  direct+image+naive iteration,       results/rq2_visual/direct-image-iter

Per repair-round cap k it reports:
  pass@k   - files whose code compiles at some round index <= k
             (round 0 = initial generation, round i = i-th repair)
  tokens@k - mean total tokens consumed per file if the loop had been capped
             at k repair rounds (over all 100 files)

Output: <group out_root>/iteration_rounds_curve[_<group>].{csv,json}
"""

import argparse
import csv
import json
from pathlib import Path

import os as _os
from pathlib import Path as _P
from dotenv import load_dotenv as _ld
_ld(_P(__file__).resolve().parents[1] / ".env")
ROOT = _P(_os.environ.get("ARKTRANS_ROOT", str(_P(__file__).resolve().parents[2])))
CAP = 10

GROUPS = {
    "rq4": {
        "src": lambda lang: ROOT / "results" / "rq4_method" / f"qwen-final-{lang}",
        "ext": lambda lang: ROOT / "results" / "rq4_method_extended" / f"qwen-final-{lang}-r{CAP}",
        "out": ROOT / "results" / "rq4_method_extended",
        "suffix": "",
    },
    "rq2": {
        "src": lambda lang: ROOT / "results" / "rq2_visual" / f"direct-image-iter-{lang}",
        "ext": lambda lang: ROOT / "results" / "rq2_visual" / f"direct-image-iter-{lang}-r{CAP}",
        "out": ROOT / "results" / "rq2_visual",
        "suffix": "_rq2",
    },
}

def merged_rounds(g: dict, lang: str):
    """Yield (file_id, rounds, is_extended) for all files of one language."""
    base = g["src"](lang)
    ext_base = g["ext"](lang)
    for t in sorted(base.glob("*/trace.json")):
        d = json.loads(t.read_text())
        fid = d["file_id"]
        rounds = d["rounds"]
        extended = False
        if not d["compiles"]:
            et = ext_base / fid / "trace.json"
            if et.exists():
                e = json.loads(et.read_text())
                extra = [r for r in e["rounds"] if r.get("round", 0) > 5]
                rounds = rounds + extra
                extended = bool(extra)
        yield fid, rounds, extended

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--group", choices=list(GROUPS), default="rq4")
    args = ap.parse_args()
    g = GROUPS[args.group]

    rows = []
    detail = {}
    for lang in ["kotlin", "swift"]:
        files = list(merged_rounds(g, lang))
        n = len(files)
        curve = []
        for k in range(0, CAP + 1):
            passed = sum(1 for _, rounds, _ in files
                         if any(r.get("compiles") and r["round"] <= k for r in rounds))
            tokens = sum(sum(r.get("tokens", 0) for r in rounds if r.get("round", -1) <= k)
                         for _, rounds, _ in files) / n
            curve.append({"cap_repair_rounds": k, "pass": passed, "rate": passed / n,
                          "tokens_mean": round(tokens)})
            rows.append({"lang": lang, "repair_rounds_cap": k, "pass": passed,
                         "n": n, "rate": round(passed / n, 2),
                         "tokens_mean": round(tokens)})
        n_ext = sum(1 for _, _, e in files if e)
        stop_counts = {}
        for fid, rounds, e in files:
            last = max(r.get("round", 0) for r in rounds)
            compiles = any(r.get("compiles") for r in rounds)
            stop = ("pass" if compiles else
                    f"stop@{last}" + ("" if last >= CAP else " (early)"))
            stop_counts[stop] = stop_counts.get(stop, 0) + 1
        detail[lang] = {"n": n, "extended_files": n_ext, "curve": curve,
                        "stop_counts": stop_counts}

    out_dir = g["out"]
    out_dir.mkdir(parents=True, exist_ok=True)
    with open(out_dir / f"iteration_rounds_curve{g['suffix']}.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)
    (out_dir / f"iteration_rounds_curve{g['suffix']}.json").write_text(
        json.dumps(detail, indent=2, ensure_ascii=False))

    print(f"[{args.group}] {'cap':>4} | {'kotlin':>14} | {'swift':>14}")
    print(f"{'':>10} | {'pass  rate  tok':>14} | {'pass  rate  tok':>14}")
    for k in range(0, CAP + 1):
        ck = next(c for c in detail["kotlin"]["curve"] if c["cap_repair_rounds"] == k)
        cs = next(c for c in detail["swift"]["curve"] if c["cap_repair_rounds"] == k)
        print(f"{k:>14} | {ck['pass']:>4} {ck['rate']:>5.0%} {ck['tokens_mean']:>5} | "
              f"{cs['pass']:>4} {cs['rate']:>5.0%} {cs['tokens_mean']:>5}")

if __name__ == "__main__":
    main()
