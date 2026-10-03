#!/bin/bash
_SD="$(cd "$(dirname "$0")" && pwd)"
[ -f "$_SD/../../.env" ] && . "$_SD/../../.env"
: "${ARKTRANS_ROOT:=$(cd "$_SD/../.." && pwd)}"
export ARKTRANS_ROOT
CR="$ARKTRANS_ROOT/scripts/rq1_zero_shot/claudecode"
export CC_KEY=$(grep '^CLAUDE_API_KEY=' "$_SD/../../.env" | cut -d= -f2)
for spec in "iter kotlin" "imgiter kotlin" "iter swift" "imgiter swift"; do
  set -- $spec
  python3 $CR/cc_rq2.py $1 $2 1 100 || true
done
