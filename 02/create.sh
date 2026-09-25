#!/bin/bash

check_free_space() {
  local free_space=$(df -h --output=avail / | tail -n 1 |
  awk '/G/{print int($1*1024)} /M/{print int($1)} /K/{print 0}')

  if [ "$free_space" -le 1024 ]; then
    echo "Attention: there is less than 1GB of space left on the disk (${free_space} MB left)" >&2
    return 1
  fi
  return 0
}

get_target_dirs() {
  find / -maxdepth 4 -type d -writable 2>/dev/null |
  grep -vE '/(bin|sbin|sys|dev|proc|run)(\/|$)'
}

create_files_in_folder() {
  local folder_path="$1"
  local file_letters="$2"
  local file_ext="$3"
  local size_num="$4"
  local size_raw="$5"
  local log_file="$6"
  local count=$(( RANDOM % 100 + 1 ))
  local j
  for (( j=1; j<=count; j++)); do
    if ! check_free_space; then
    return 1
    fi
    local file_name=$(generate_file_name "$file_letters" "$file_ext" "$j")
    local file_path="$folder_path/$file_name"
    fallocate -l "${size_num}M" "$file_path"
    echo "$file_path $(date '+%Y-%m-%d %H:%M:%S') $size_raw" >> "$log_file"
  done
}

creation() {
  local folder_letters="$1"  
  local file_chars="$2"
  local file_size="$3"
  local log_file="$(pwd)/file.log"

  local file_name_letters=${file_chars%.*}
  local file_ext=${file_chars#*.}
  local size_mb=${file_size%[mM][bB]}

  local target_dirs=()
  mapfile -t target_dirs < <(get_target_dirs)
  if [ "${#target_dirs[@]}" -eq 0 ]; then
    echo "Error: No directories found" >&2
    return 1
  fi

  local i
  for (( i=1; i<=100; i++ )); do
    if ! check_free_space; then
    return 1
    fi
    local random_dirs="${target_dirs[RANDOM % ${#target_dirs[@]}]}"
    local folder_name=$(generate_folder_name "$folder_letters" "$i")
    local folder_path="$random_dirs/$folder_name"
    mkdir -p "$folder_path"
    echo "$folder_path $(date '+%Y-%m-%d %H:%M:%S')" >> "$log_file"
    if ! create_files_in_folder "$folder_path" "$file_name_letters" "$file_ext" "$size_mb" "$file_size" "$log_file"; then
    return 1
    fi
  done
}