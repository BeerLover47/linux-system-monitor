#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Error: One argument"
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "Error: Files not found"
  exit 1
fi
  count=0
  while IFS= read -r line; do
    (( count++ ))
    echo "$count: $line"
  done < "$1"
echo "Total lines: $count"