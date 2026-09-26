#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Error: One argument"
  exit 1
fi

parse_string() {
    local name="$1"
    local first_char=${name:0:1}
    local ext_char=${name: -1}
    local length_char=${#name}

    if (( length_char < 4 )); then
      echo "TOO SHORT: $length_char"
      exit 1
    else
      echo "First: $first_char"
      echo "Last: $ext_char"
      echo "Length: $length_char"
    fi
}

parse_string "$1"