get_block() {  # $1=lang $2=id -> print that prompt block (verbatim CodeArts protocol)
  python3 - "$1" "$2" << 'PY'
import sys, re, os
lang, i = sys.argv[1], int(sys.argv[2])
path = os.path.join(os.environ["ARKTRANS_ROOT"], "scripts", "rq1_zero_shot", "codearts", f"prompts_rq1_filelevel_{lang}.txt")
text = open(path, encoding="utf-8").read()
blocks = re.split(r"^================ 会话 \d+/100 ================\n", text, flags=re.M)[1:]
assert 1 <= i <= len(blocks), f"block {i} not found"
print(blocks[i-1].strip())
PY
}
