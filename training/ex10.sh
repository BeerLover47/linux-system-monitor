#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Error: Only two arguments" >&2
  exit 1
fi

timestamp() {
  #local arg1="$1"
  #local arg2="$2"

  local ts_start=$(date -d "$1" +%s)
  local ts_end=$(date -d "$2" +%s)
  #local diff_minutes=$(( (ts_end - ts_start) / 60 ))

  if [[ $ts_end -lt $ts_start ]]; then
    echo "Error: End time cannot be earlier than start time" >&2
    exit 1
  else
    local diff_minutes=$(( (ts_end - ts_start) / 60 ))
    echo "Start: $ts_start"
    echo "End: $ts_end"
    echo "Diff: $diff_minutes"
  fi
}

timestamp "$1" "$2"