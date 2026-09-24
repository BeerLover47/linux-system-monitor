#!/bin/bash


generate_folder_name() {
  local letters="$1"
  local index="$2"
  local date_str=$(date +%d%m%y)
  local name="$letters"
  local first_char="${letters:0:1}"
  local last_char="${letters: -1}"

  while [ "${#name}" -lt 5 ]; do
    name="${first_char}${name}"
  done
  
  local i
  for (( i=1; i<index; i++ )); do
    name="${name}${last_char}"
  done
  echo "${name}_${date_str}"
}

generate_file_name() {
    local letters="$1"
    local ext="$2"
    local index="$3"
    local base_name="$(generate_folder_name "$letters" "$index")"
    echo "${base_name}.${ext}"
}