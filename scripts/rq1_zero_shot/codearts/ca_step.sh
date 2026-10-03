#!/bin/bash
_SD="$(cd "$(dirname "$0")" && pwd)"
[ -f "$_SD/../../.env" ] && . "$_SD/../../.env"
: "${ARKTRANS_ROOT:=$(cd "$_SD/../../.." && pwd)}"
export ARKTRANS_ROOT
ROOT="$ARKTRANS_ROOT/scripts/rq1_zero_shot/codearts"
WS="$ARKTRANS_ROOT/codearts_workspace"
LOG=$ROOT/auto_run.log
log() { echo "[$(date '+%m-%d %H:%M:%S')] $*" | tee -a "$LOG"; }
log "===== paced stepper start: swift 87-100 (~115s interval, resumes on output) ====="
for i in $(seq 87 100); do
  f="$WS/out/swift/$(printf '%03d' $i).ets"
  for attempt in 1 2 3; do
    [ -s "$f" ] && break
    pkill -f "ca_auto.sh swift" 2>/dev/null; sleep 2
    nohup $ROOT/ca_auto.sh swift $i $i > $ROOT/auto_swift.out 2>&1 &
    BPID=$!
    for w in $(seq 1 16); do
      sleep 15
      [ -s "$f" ] && break
      kill -0 $BPID 2>/dev/null || break
    done
    if [ ! -s "$f" ]; then
      kill $BPID 2>/dev/null; sleep 3
      log "stepper: swift/$i attempt ${attempt} produced no file, reopening session"
    fi
  done
  if [ -s "$f" ]; then
    log "stepper: swift/$i done ($(wc -c < "$f")B)"
  else
    log "stepper: swift/$i failed 3 attempts, skipping (backfill later)"
  fi
done
log "===== paced stepper end: swift 87-100 ====="
