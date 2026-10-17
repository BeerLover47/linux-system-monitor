#!/bin/bash

validate_arg() {
if [ "$#" -ne 0 ]; then
  echo "Error: Too many arguments" >&2
  exit 1
fi
}
