"""Batch build -> install + screenshot one by one. Each .ets gets a unique bundleName.

Phase 1 uses parallel packaging (hap_pool.build_hap_batch, lane-based TemplatePool
with least-loaded queuing). Usage: test_screen.py <ets_dir> <screenshot_dir> <hap_dir> [capacity]
"""
import sys
from pathlib import Path
from tqdm import tqdm  # still used in Phase 3

sys.path.insert(0, str(Path(__file__).resolve().parent))

from harmony_auto import *
from hap_pool import build_hap_batch


codes_dir = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("./deepseek")
screenshot_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("./screenshot/deepseek")
hap_dir = Path(sys.argv[3]) if len(sys.argv) > 3 else Path("./hap_cache")
capacity = int(sys.argv[4]) if len(sys.argv) > 4 else 4  # parallel lanes
os.makedirs(screenshot_dir, exist_ok=True)
os.makedirs(hap_dir, exist_ok=True)

env = detect_env()
print(env.summary())

avd = ensure_avd(env,
    os_version="HarmonyOS 6.0.2(22)",
    width=720, height=1280, dpi=320, diagonal=4.65, device_type="phone",
)
print(f"\nAVD: {avd.name}")

# -- Phase 1: parallel batch build, HAPs stored in hap_cache --
ets_files = sorted(codes_dir.glob("*.ets"))
print(f"\n[Phase 1] Building {len(ets_files)} files (capacity={capacity})...")

stat = build_hap_batch(env, ets_files, hap_dir, capacity=capacity)
print(f"[Phase 1] compiled={stat['compiled']} failed={stat['failed']}")

stop_hvigor_daemon(env)

print("\n[Phase 2] Starting emulator...")
start_emulator(env, avd.name)
wait_for_device(env)

# -- Phase 3: install + screenshot one by one --
hap_files = sorted(hap_dir.glob("*.hap"))
print(f"\n[Phase 3] Installing & screenshot {len(hap_files)} HAPs...")

err_dict = {}
for hap_path in tqdm(hap_files, desc="Install+Screenshot"):
    print(f"In {hap_path.stem}")
    ss_path = str((screenshot_dir / f"{hap_path.stem}.jpeg").absolute())
    bundle = f"com.test.ui.{hap_path.stem}"
    failed_dest = hap_dir / f"{hap_path.stem}.FAILED"

    install = install_and_launch(env, str(hap_path), bundle_name=bundle)
    if not install["success"]:
        err = extract_errors(install["stderr"])
        print(f"\n[INSTALL FAIL] {hap_path.name}: {err[:300]}")
        # write a .FAILED file with the full reason + log (full stderr incl. crash hilog)
        full_reason = install["stderr"] or err or "(no error detail)"
        failed_dest.write_text(
            f"{hap_path.name} failed:\n{full_reason}\n"
            f"--- extracted errors ---\n{err}",
            encoding="utf-8",
        )
        err_dict[hap_path.name] = f"Install Failed: {err[:120]}"
        continue

    screenshot(env, ss_path)
    print(f"  -> {hap_path.stem}.jpeg")

print(f"\n[Done] Screenshots: {screenshot_dir}")
if err_dict:
    print(f"Errors ({len(err_dict)}):")
    for k, v in err_dict.items():
        print(f"  {k}: {v[:120]}")
