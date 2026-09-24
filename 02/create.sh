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

creation() {
    local base_dir="$1"
    local file_chars="$2"
    
}