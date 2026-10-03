#!/usr/bin/env python3
"""codearts butler: watches out/<lang>/, and whenever the next expected
.ets lands (non-empty), loads the NEXT prompt block into the clipboard via
pbcopy. The human only: new chat -> Cmd+V -> Enter -> (approve edit).

Run:  python3 codearts_butler.py kotlin        # or swift
"""
import subprocess
import sys
import time
import pathlib

import os as _os
from pathlib import Path as _P
from dotenv import load_dotenv as _ld
_ld(_P(__file__).resolve().parents[2] / ".env")
_ROOT = _P(_os.environ.get("ARKTRANS_ROOT", str(_P(__file__).resolve().parents[3])))
WS = _ROOT / "codearts_workspace"
PROMPTS = _ROOT / "scripts" / "rq1_zero_shot" / "codearts"

def blocks(lang):
    text = (PROMPTS / f'prompts_rq1_filelevel_{lang}.txt').read_text(encoding='utf-8')
    out = {}
    cur_id, buf = None, []
    for line in text.splitlines():
        if line.startswith('================ 会话 '):
            if cur_id:
                out[cur_id] = "\n".join(buf).strip()
            cur_id = int(line.split('/')[0].split()[-1])
            buf = []
        elif cur_id:
            buf.append(line)
    if cur_id:
        out[cur_id] = "\n".join(buf).strip()
    return out

def main():
    lang = sys.argv[1]
    blks = blocks(lang)
    done = set()
    for i in range(1, 101):
        f = WS / 'out' / lang / f'{i:03d}.ets'
        if f.exists() and f.stat().st_size > 10:
            done.add(i)
    nxt = min((i for i in range(1, 101) if i not in done), default=None)
    print(f'[{lang}] 已完成 {len(done)}/100，当前待发：{nxt}')
    if nxt:
        subprocess.run(['pbcopy'], input=blks[nxt].encode())
        print(f'>>> 剪贴板已装好 {nxt:03d} 的 prompt（新建会话→⌘V→回车→批准编辑）')
    while nxt:
        time.sleep(5)
        f = WS / 'out' / lang / f'{nxt:03d}.ets'
        if f.exists() and f.stat().st_size > 10:
            done.add(nxt)
            print(f'[{time.strftime("%H:%M")}] {nxt:03d}.ets 完成（{len(done)}/100）', flush=True)
            empty = [i for i in range(1, 101)
                     if (WS/'out'/lang/f'{i:03d}.ets').exists()
                     and (WS/'out'/lang/f'{i:03d}.ets').stat().st_size <= 10]
            if empty:
                print(f'  ⚠️ 空文件: {empty}')
            nxt = min((i for i in range(1, 101) if i not in done), default=None)
            if nxt:
                subprocess.run(['pbcopy'], input=blks[nxt].encode())
                print(f'>>> 剪贴板已装好 {nxt:03d} 的 prompt', flush=True)
            else:
                print(f'*** {lang} 全部 100 个完成！***')
                subprocess.run(['pbcopy'], input=f'{lang} 100 files done'.encode())
                break

if __name__ == '__main__':
    main()
