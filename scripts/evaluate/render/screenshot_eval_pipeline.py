"""One-key pipeline: screenshot + evaluation.

Chains test_screen.py (screenshot) and evaluation_pipeline.py (scoring):
    .ets outputs -> test_screen.py screenshots -> evaluation_pipeline.py scores -> CSV/JSON
"""
import argparse
import subprocess
import sys
from pathlib import Path

import os

SCRIPT_DIR = Path(__file__).resolve().parent                        # .../scripts/evaluate/render
BASE_DIR = Path(os.environ.get("ARKTRANS_ROOT", str(Path(__file__).resolve().parents[3])))
TEST_SCREEN = SCRIPT_DIR / "test_screen.py"
EVAL_PIPELINE = SCRIPT_DIR.parent / "evaluation_pipeline.py"


def main():
    p = argparse.ArgumentParser(description="screenshot + evaluation one-key pipeline")
    p.add_argument("--ets-dir", required=True, help="directory of generated .ets files")
    p.add_argument("--language", choices=["kotlin", "swift"], required=True)
    p.add_argument("--model", required=True, help="model name (screenshot dir name scanned by the evaluator)")
    p.add_argument("--base-dir", default=str(BASE_DIR))
    p.add_argument("--screenshot-out", default=str(BASE_DIR / "screenshot_eval"))
    p.add_argument("--hap-cache", default=str(BASE_DIR / "hap_cache"))
    p.add_argument("--output-dir", default=str(BASE_DIR / "evaluation_results"))
    p.add_argument("--python", default=sys.executable, dest="sir_python")
    p.add_argument("--skip-screenshot", action="store_true", help="skip screenshots (already have them, evaluate only)")
    p.add_argument("--capacity", type=int, default=5, help="parallel HAP build lanes (default 5)")
    args = p.parse_args()

    base = Path(args.base_dir)
    # screenshot dir = {screenshot_out}/{model}/ (test_screen writes flat there; the evaluator scans it)
    screenshot_dir = Path(args.screenshot_out) / args.model
    hap_cache = Path(args.hap_cache) / f"{args.language}_{args.model}"

    if not args.skip_screenshot:
        print(f"[1/2] screenshot: {args.ets_dir} -> {screenshot_dir} (capacity={args.capacity})")
        cmd = [args.sir_python, str(TEST_SCREEN), args.ets_dir, str(screenshot_dir), str(hap_cache), str(args.capacity)]
        r = subprocess.run(cmd)
        if r.returncode != 0:
            print("screenshot stage failed")
            sys.exit(r.returncode)
    else:
        print(f"[1/2] skip screenshots (using existing: {screenshot_dir})")

    print(f"[2/2] evaluate: {screenshot_dir} -> {args.output_dir}")
    lang_dir_arg = "--kotlin-dir" if args.language == "kotlin" else "--swift-dir"
    # the evaluator scans subdirectories (=model names) under {screenshot_out}, so pass the whole root
    eval_root = Path(args.screenshot_out)
    cmd = [
        args.sir_python, str(EVAL_PIPELINE),
        "--base-dir", str(base),
        "--language", args.language,
        lang_dir_arg, str(eval_root),
        "--output-dir", str(args.output_dir),
    ]
    r = subprocess.run(cmd)
    if r.returncode != 0:
        print("evaluation stage failed")
        sys.exit(r.returncode)

    print(f"\n[done] evaluation results: {Path(args.output_dir)}")


if __name__ == "__main__":
    main()
