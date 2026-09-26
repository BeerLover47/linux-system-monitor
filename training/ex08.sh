#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo "Error: Invalid arguments" >&2
  exit 1
fi

arrays_test() {
  local items=("$@")
  local total="${#items[@]}"
  local first="${items[0]}"
  local last="${items[-1]}"
  local all="${items[@]}"

  echo "Total: $total"
  echo "First: $first"
  echo "Last: $last"
  echo "All: $all"
}

arrays_test "$@"