#!/bin/bash
_SD="$(cd "$(dirname "$0")" && pwd)"
[ -f "$_SD/../../.env" ] && . "$_SD/../../.env"
: "${ARKTRANS_ROOT:=$(cd "$_SD/../../.." && pwd)}"
export ARKTRANS_ROOT
ROOT="$ARKTRANS_ROOT/scripts/rq1_zero_shot/codearts"
WS="$ARKTRANS_ROOT/codearts_workspace"

load_block() {  # $1=lang $2=id(1-100)
  python3 - "$1" "$2" << 'PY'
import sys, re, os, subprocess
lang, i = sys.argv[1], int(sys.argv[2])
path = os.path.join(os.environ["ARKTRANS_ROOT"], "scripts", "rq1_zero_shot", "codearts", f"prompts_rq1_filelevel_{lang}.txt")
text = open(path, encoding="utf-8").read()
blocks = re.split(r"^================ 会话 \d+/100 ================\n", text, flags=re.M)[1:]
assert 1 <= i <= len(blocks), f"block {i} not found (total {len(blocks)})"
block = blocks[i-1].strip() + "\n"
p = subprocess.run(["pbcopy"], input=block.encode(), check=True)
PY
}

snap() {  # $1=output path
  screencapture -x /tmp/_raw_shot.png
  sips -z 900 1440 /tmp/_raw_shot.png --out "$1" >/dev/null 2>&1
}

check_out() {  # $1=lang $2=id
  f="$WS/out/$1/$(printf '%03d' $2).ets"
  if [ -s "$f" ]; then echo "OK $(wc -c < "$f") bytes"; else echo "EMPTY"; fi
}
