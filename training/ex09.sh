#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Error: One argument" >&2
  exit 1
fi

log_parser() {
  read -r log_path log_date log_time log_size <<< "$1"
  local size_mb=${log_size%[mM][bB]}
  echo "Path: $log_path"
  echo "Date: $log_date"
  echo "Time: $log_time"
  echo "Size: $size_mb"
}

log_parser "$1"