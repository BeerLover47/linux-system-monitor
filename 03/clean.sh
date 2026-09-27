#!/bin/bash

clean_by_log() {
  echo "Cleanup method 1: by log file"

  read -p "Enter path to log file: " log_file
  if [ ! -f "$log_file" ]; then
    echo "Error: File not found" >&2
    exit 1
  fi

  local count=0
  while IFS= read -r line; do
    read -r target_path _ <<< "$line"
    if [[ "$target_path" =~ ^/ ]] && [ "$target_path" != "/" ] && [ -e "$target_path" ]; then
      rm -rf "$target_path"
    (( count++ ))
    echo "$count: $line"
    fi
  done < "$log_file"
  echo "Total deleted: $count objects."
}

clean_by_time() {
  echo "Cleanup method 2: by creation date/time"
  
  read -r -p "Enter start time (YYYY-MM-DD HH:MM): " start_date
  read -r -p "Enter end time (YYYY-MM-DD HH:MM): " end_date
  
  local ts_start=$(date -d "$start_date" +%s 2>/dev/null)
  local ts_end=$(date -d "$end_date" +%s 2>/dev/null)

  if [ -z "$ts_start" ] || [ -z "$ts_end" ]; then
    echo "Error: Invalid format" >&2
    exit 1
  fi

  if [[ $ts_end -lt $ts_start ]]; then
    echo "Error: End time cannot be earlier than start time" >&2
    exit 1
  fi

  local find_start="${start_date}:00"
  local find_end="${end_date}:59"

  while IFS= read -r target; do
    if [ -e "$target" ]; then
      rm -rf "$target"
      echo "Deleted: $target"
    fi
  done < <(find / \
    \( -path '/proc' -o -path '/sys' -o -path '/dev' -o -path '/run' -o -path '/bin' -o -path '/sbin' -o -path '/mnt' -o -path '/media' \) -prune \
    -o -newermt "$find_start" ! -newermt "$find_end" -name "*_[0-9][0-9][0-9][0-9][0-9][0-9]*" -print 2>/dev/null)
}

clean_by_mask() {
  echo "Cleanup method 3: by name mask"

  read -r -p "Enter mask (format _DDMMYY or characters_DDMMYY): " regex_date
  if [ -z "$regex_date" ]; then
    echo "Error: please enter mask" >&2
    exit 1
  fi

  while IFS= read -r target; do
    if [ -e "$target" ]; then
      rm -rf "$target"
      echo "Deleted: $target"
    fi
  done < <(find / \
    \( -path '/proc' -o -path '/sys' -o -path '/dev' -o -path '/run' -o -path '/bin' -o -path '/sbin' -o -path '/mnt' -o -path '/media' \) -prune \
    -o -name "*${regex_date}*" -print 2>/dev/null)
}
