#!/bin/bash

validate_args() {
  if [ "$#" -ne 3 ]; then
    echo "Error: There are only three arguments" >&2
    exit 1
  fi

  local letters_arg1='^[a-zA-Z]{1,7}$'
  if [[ ! "$1" =~ $letters_arg1 ]]; then
    echo "Error: Argument "$1" must contain from 1 to 7 letters" >&2
    exit 1
  fi

  local letters_arg2='^([a-zA-Z]{1,7})\.([a-zA-Z]{1,3})$' 
  if [[ ! "$2" =~ $letters_arg2 ]]; then
    echo "Error: Invalid format" >&2
    exit 1
  fi

  local size_mb='^([1-9]|[1-9][0-9]|100)[mM][bB]$'
  if [[ ! "$3" =~ $size_mb ]]; then
    echo "Error: Size must be an integer from 1 to 100" >&2
    exit 1
  fi
}