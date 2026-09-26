#!/bin/bash

if [ "$#" -ne 1 ]; then
   echo "Error: One argument" >&2
   exit 1
fi

test_fs() {
  local target="$1"
  if [ ! -e "$target" ]; then
    echo "NOT FOUND"
    exit 1
  fi

  if [ -d "$target" ]; then
    echo "TYPE: DIRECTORY"
  elif [ -f "$target" ]; then
    echo "TYPE: FILE"
  fi  
  if [ -w "$target" ]; then
    echo "WRITABLE: YES"
  else  
    echo "WRITABLE: NO"
  fi  
    
}

test_fs "$1"