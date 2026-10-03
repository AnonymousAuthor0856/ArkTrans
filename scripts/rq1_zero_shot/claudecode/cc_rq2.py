#!/usr/bin/env python3
import json, os, re, shutil, subprocess, sys, tempfile, time
from pathlib import Path

import os as _os
from pathlib import Path as _P
from dotenv import load_dotenv as _ld
_ld(_P(__file__).resolve().parents[2] / ".env")
ROOT = _os.environ.get("ARKTRANS_ROOT", str(_P(__file__).resolve().parents[3]))
CR = f"{ROOT}/scripts/rq1_zero_shot/codearts"
OUTROOT = f"{ROOT}/results/rq2_claudecode"
LOG = f"{ROOT}/scripts/rq1_zero_shot/claudecode/cc_run.log"
MAX_REPAIR = 5
CALL_TIMEOUT = 480

HVIGORW = _os.environ.get("HVIGORW", "hvigorw")
JAVA_HOME = _os.environ.get("JAVA_HOME", "")
TEMPLATE = _P(_os.environ.get("MINIMAL_HOS_TEMPLATE",
               str(_P(__file__).resolve().parents[1] / "evaluate" / "minimal_hos")))

def compile_one(ets_file):
    with tempfile.TemporaryDirectory() as tmpdir:
        project = Path(tmpdir) / "test"
        shutil.copytree(TEMPLATE, project, dirs_exist_ok=True,
                        ignore=shutil.ignore_patterns('.idea', '.git', 'build', '.hvigor'))
        shutil.copy(ets_file, project / "entry" / "src" / "main" / "ets" / "pages" / "Index.ets")
        env = os.environ.copy()
        env["JAVA_HOME"] = JAVA_HOME
        env["PATH"] = f"{JAVA_HOME}/bin:{Path(HVIGORW).parent}:{env.get('PATH', '')}"
        try:
            r = subprocess.run([HVIGORW, "--no-daemon", "assembleHap"], cwd=str(project),
                               capture_output=True, text=True, timeout=240, env=env)
        except subprocess.TimeoutExpired:
            return False, ["TIMEOUT"], ""
        output = r.stdout + r.stderr
        output = re.sub(r'\x1b\[[0-9;]*m', '', output)
        output = re.sub(r'\[\d+m', '', output)
        if r.returncode == 0:
            return True, [], output
        errors = re.findall(
            r'\d+\s*ERROR:\s*(\d+)\s*ArkTS\s*Compiler\s*Error\s*\n'
            r'Error\s*Message:\s*(.+?)At\s*File:\s*[^:]+:(\d+):(\d+)',
            output, re.DOTALL)
        return False, [f"[{c}] Line {l}: {' '.join(m.split())}" for c, m, l, _ in errors], output

ENV = os.environ.copy()
ENV["ANTHROPIC_BASE_URL"] = "https://xiaoai.plus"
ENV["ANTHROPIC_AUTH_TOKEN"] = ENV.get("CC_KEY", "")
ENV["CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC"] = "1"
ENV.pop("CLAUDE_CODE_ENTRYPOINT", None)

def log(msg):
    line = f"[{time.strftime('%m-%d %H:%M:%S')}] {msg}"
    print(line, flush=True)
    open(LOG, "a").write(line + "\n")

def get_block(lang, i):
    text = open(f"{CR}/prompts_rq1_filelevel_{lang}.txt", encoding="utf-8").read()
    blocks = re.split(r"^================ 会话 \d+/100 ================\n", text, flags=re.M)[1:]
    return blocks[i - 1].strip()

def call_claude(workdir, prompt, session=None):
    cmd = ["claude", "-p", prompt, "--model", "claude-sonnet-4-6",
           "--permission-mode", "acceptEdits", "--max-turns", "6",
           "--output-format", "json"]
    if session:
        cmd += ["--resume", session]
    r = subprocess.run(cmd, cwd=workdir, env=ENV, capture_output=True, text=True, timeout=CALL_TIMEOUT)
    try:
        d = json.loads(r.stdout)
        return d.get("session_id"), (d.get("result") or ""), d.get("num_turns"), r.returncode
    except json.JSONDecodeError:
        return session, "", 0, r.returncode

REPAIR_TMPL = (
    "You are an expert ArkTS developer. Fix the compilation errors in the provided code. "
    "Output ONLY the fixed ArkTS code, no explanations.\n\n"
    "The ArkTS code in out/{lang}/{id}.ets has compilation errors:\n\n"
    "**Compiler Errors:**\n{errors}\n\n"
    "Update the file out/{lang}/{id}.ets in place with the complete fixed code."
)

def run_file(config, lang, i):
    ets = Path(f"{OUTROOT}/{config}/{lang}/{i:03d}/out/{lang}/{i:03d}.ets")
    if ets.exists() and ets.stat().st_size > 50:
        return
    wd = Path(f"{OUTROOT}/{config}/{lang}/{i:03d}")
    (wd / "out" / lang).mkdir(parents=True, exist_ok=True)
    trace = {"config": config, "lang": lang, "file_id": f"{i:03d}", "rounds": []}
    prompt = get_block(lang, i)
    if config == "imgiter":
        shutil.copy(f"{ROOT}/suc/{lang}_img/{i:03d}.png", wd / "ref.png")
        prompt += "\n\nTarget UI reference screenshot: @ref.png"
    sid, res, turns, rc = call_claude(str(wd), prompt)
    trace["session_id"] = sid
    if not ets.exists():
        json.dump(trace, open(wd / "trace.json", "w"), ensure_ascii=False, indent=1)
        raise RuntimeError("ROUND0_NO_OUTPUT")
    ok, errors, _ = compile_one(ets)
    trace["rounds"].append({"round": 0, "compiles": ok, "errors": len(errors), "turns": turns})
    log(f"{config}/{lang}/{i:03d} round0 {'PASS' if ok else f'FAIL({len(errors)})'}")
    r = 0
    while not ok and r < MAX_REPAIR:
        r += 1
        msg = REPAIR_TMPL.format(lang=lang, id=f"{i:03d}", errors="\n".join(errors[:15]) or "compile failed")
        sid, _, turns, rc = call_claude(str(wd), msg, session=sid)
        ok, errors, _ = compile_one(ets) if ets.exists() else (False, ["NO_OUTPUT"], None)
        trace["rounds"].append({"round": r, "compiles": ok, "errors": len(errors), "turns": turns})
        log(f"{config}/{lang}/{i:03d} round{r} {'PASS' if ok else f'FAIL({len(errors)})'}")
    trace["final_pass"] = ok
    trace["r0_pass"] = trace["rounds"][0]["compiles"]
    json.dump(trace, open(wd / "trace.json", "w"), ensure_ascii=False, indent=1)

def main():
    config, lang, start, end = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4])
    if not ENV["ANTHROPIC_AUTH_TOKEN"]:
        sys.exit("缺少 CC_KEY")
    log(f"===== 启动: claude-code {config} {lang} {start}-{end} =====")
    consec_fail = 0
    for i in range(start, end + 1):
        try:
            run_file(config, lang, i)
            consec_fail = 0
        except subprocess.TimeoutExpired:
            log(f"{config}/{lang}/{i:03d} 会话超时跳过")
        except Exception as e:
            log(f"{config}/{lang}/{i:03d} 异常: {e}")
            if "NO_OUTPUT" in str(e):
                consec_fail += 1
                if consec_fail >= 5:
                    log(f"连续5个文件无产出, 疑似配额/接口失效, 中止批量")
                    sys.exit(2)
            else:
                consec_fail = 0
    log(f"===== 结束: claude-code {config} {lang} {start}-{end} =====")

if __name__ == "__main__":
    main()
