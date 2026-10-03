#!/bin/bash
_SD="$(cd "$(dirname "$0")" && pwd)"
[ -f "$_SD/../../.env" ] && . "$_SD/../../.env"
: "${ARKTRANS_ROOT:=$(cd "$_SD/../.." && pwd)}"
export ARKTRANS_ROOT
CR="$ARKTRANS_ROOT/scripts/rq1_zero_shot/codex"
export XIAOAI_KEY=$(grep '^GPT_API_KEY=' "$_SD/../../.env" | cut -d= -f2)
python3 $CR/codex_rq2.py kotlin 2 100 || true
python3 $CR/codex_rq2.py swift 1 100 || true
