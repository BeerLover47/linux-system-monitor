#!/bin/bash


validate_arg() {
if [ "$#" -ne 1 ]; then
  echo "Error: One argument." >&2
  exit 1
fi

if [[ ! "$1" =~ ^[1-4]$ ]]; then
  echo "Error: An argument from one to four." >&2
  exit 1
fi
}

check_logs() {
  local dir="$1"
  if ! compgen -G "$dir/*.log" >/dev/null; then
    echo "Error: Logs not found" >&2
    exit 1
  fi
}