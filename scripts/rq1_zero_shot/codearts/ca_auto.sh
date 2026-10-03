#!/bin/bash
_SD="$(cd "$(dirname "$0")" && pwd)"
[ -f "$_SD/../../.env" ] && . "$_SD/../../.env"
: "${ARKTRANS_ROOT:=$(cd "$_SD/../../.." && pwd)}"
export ARKTRANS_ROOT
ROOT="$ARKTRANS_ROOT/scripts/rq1_zero_shot/codearts"
WS="$ARKTRANS_ROOT/codearts_workspace"
SHOTS=$ROOT/shots
LOG=$ROOT/auto_run.log
mkdir -p "$SHOTS"
source "$ROOT/ca_helpers.sh"

log() { echo "[$(date '+%m-%d %H:%M:%S')] $*" | tee -a "$LOG"; }

front() {
  osascript -e 'tell application "System Events" to set frontmost of process "Electron" to true' 2>/dev/null
  sleep 1.0
}

LANG_=$1; START=$2; END=$3
log "===== batch start: $LANG_ $START-$END ====="

for ((i=START; i<=END; i++)); do
  f="$WS/out/$LANG_/$(printf '%03d' $i).ets"
  if [ -s "$f" ]; then log "$LANG_/$i exists ($(wc -c < "$f")B), skip"; continue; fi

  load_block "$LANG_" "$i" || { log "$LANG_/$i block extraction failed, skip"; continue; }

  front
  cliclick c:1267,85
  sleep 1.5

  cliclick c:1187,700
  sleep 0.8
  osascript -e 'tell application "System Events" to keystroke "v" using command down'
  sleep 1.8

  cliclick c:1391,745
  snap "$SHOTS/${LANG_}_$(printf '%03d' $i)_send.png"
  log "$LANG_/$i sent, polling"

  ok=0; stable=0; last=-1; waited=0
  while [ $waited -lt 2400 ]; do   # max 40 min (server throttling makes output very slow)
    sleep 30; waited=$((waited+30))
    if [ -s "$f" ]; then
      sz=$(wc -c < "$f")
      if [ "$sz" = "$last" ] && [ "$sz" -gt 50 ]; then
        stable=$((stable+1))
        if [ $stable -ge 3 ]; then ok=1; break; fi
      else
        stable=0; last=$sz
      fi
    fi
  done

  if [ $ok -eq 1 ]; then
    sleep 20   # let the session end naturally to avoid truncating output
    snap "$SHOTS/${LANG_}_$(printf '%03d' $i)_done.png"
    log "$LANG_/$i done $(wc -c < "$f")B in ${waited}s"
  else
    snap "$SHOTS/${LANG_}_$(printf '%03d' $i)_timeout.png"
    log "$LANG_/$i timed out unstable, on disk: $( [ -s "$f" ] && wc -c < "$f" || echo empty )"
  fi
done
log "===== batch end: $LANG_ $START-$END ====="
