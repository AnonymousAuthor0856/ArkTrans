#!/usr/bin/env python3
import json, os, re, shutil, subprocess, sys, tempfile
from pathlib import Path

import os as _os
from pathlib import Path as _P
from dotenv import load_dotenv as _ld
_ld(_P(__file__).resolve().parents[2] / ".env")
HVIGORW = _os.environ.get("HVIGORW", "hvigorw")
JAVA_HOME = _os.environ.get("JAVA_HOME", "")
TEMPLATE = _P(_os.environ.get("MINIMAL_HOS_TEMPLATE",
               str(_P(__file__).resolve().parents[2] / "evaluate" / "minimal_hos")))

SRC = Path(sys.argv[1])
OUT_JSON = Path(sys.argv[2])

def compile_one(ets_file: Path):
    with tempfile.TemporaryDirectory() as tmpdir:
        project = Path(tmpdir) / "test"
        shutil.copytree(TEMPLATE, project, dirs_exist_ok=True,
                        ignore=shutil.ignore_patterns('.idea', '.git', 'build', '.hvigor'))
        shutil.copy(ets_file, project / "entry" / "src" / "main" / "ets" / "pages" / "Index.ets")
        env = os.environ.copy()
        env["JAVA_HOME"] = JAVA_HOME
        env["PATH"] = f"{JAVA_HOME}/bin:{Path(HVIGORW).parent}:{env.get('PATH', '')}"
        try:
            result = subprocess.run([HVIGORW, "--no-daemon", "assembleHap"], cwd=str(project),
                                    capture_output=True, text=True, timeout=240, env=env)
        except subprocess.TimeoutExpired:
            return False, ["TIMEOUT"], ""
        output = result.stdout + result.stderr
        output = re.sub(r'\x1b\[[0-9;]*m', '', output)
        output = re.sub(r'\[\d+m', '', output)
        if result.returncode == 0:
            return True, [], output
        errors = []
        blocks = re.findall(
            r'\d+\s*ERROR:\s*(\d+)\s*ArkTS\s*Compiler\s*Error\s*\n'
            r'Error\s*Message:\s*(.+?)At\s*File:\s*[^:]+:(\d+):(\d+)',
            output, re.DOTALL)
        for code, msg, line, col in blocks:
            clean = ' '.join(msg.split())
            errors.append(f"[{code}] Line {line}: {clean}")
        return False, errors, output

results = {}
files = sorted(SRC.glob("*.ets"))
for i, f in enumerate(files, 1):
    ok, errors, _ = compile_one(f)
    results[f.stem] = {"pass": ok, "errors": errors[:10]}
    print(f"[{i}/{len(files)}] {f.stem}: {'PASS' if ok else f'FAIL({len(errors)}错误)'}", flush=True)
    OUT_JSON.write_text(json.dumps(results, ensure_ascii=False, indent=1))

passed = sum(1 for v in results.values() if v["pass"])
print(f"===== 完成: {passed}/{len(files)} 通过 ({passed/len(files)*100:.0f}%) =====", flush=True)
