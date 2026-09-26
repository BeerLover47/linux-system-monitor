#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Error: One argument"
  exit 1
fi

creation() {
    local file_chars="$1"
    local file_name_letters=${file_chars%.*}
    local file_ext=${file_chars#*.}
    echo "Full: $file_chars"
    echo "Name: $file_name_letters"
    echo "Ext: $file_ext"
}

creation "$1"