#!/bin/bash
_SD="$(cd "$(dirname "$0")" && pwd)"
[ -f "$_SD/../../.env" ] && . "$_SD/../../.env"
: "${ARKTRANS_ROOT:=$(cd "$_SD/../../.." && pwd)}"
export ARKTRANS_ROOT
ROOT="$ARKTRANS_ROOT/scripts/rq1_zero_shot/codearts"
WS="$ARKTRANS_ROOT/codearts_workspace"
LOG=$ROOT/auto_run.log
LANG_=$1; START=$2; END=$3
log() { echo "[$(date '+%m-%d %H:%M:%S')] $*" | tee -a "$LOG"; }
log "===== watchdog batch start: $LANG_ $START-$END (single file + 14-min stall restart) ====="
while true; do
  MISS=""
  for i in $(seq $START $END); do
    [ -s "$WS/out/$LANG_/$(printf '%03d' $i).ets" ] || { MISS=$i; break; }
  done
  [ -z "$MISS" ] && break
  nohup $ROOT/ca_auto.sh $LANG_ $MISS $MISS > $ROOT/auto_${LANG_}.out 2>&1 &
  BPID=$!
  for w in $(seq 1 28); do
    sleep 30
    kill -0 $BPID 2>/dev/null || break
    [ -s "$WS/out/$LANG_/$(printf '%03d' $MISS).ets" ] && break
  done
  if kill -0 $BPID 2>/dev/null && [ ! -s "$WS/out/$LANG_/$(printf '%03d' $MISS).ets" ]; then
    kill $BPID 2>/dev/null; sleep 3
    log "watchdog: $LANG_/$MISS stalled >14min, reopening session"
  else
    wait $BPID 2>/dev/null
  fi
done
log "===== watchdog batch done: $LANG_ $START-$END all non-empty ====="
