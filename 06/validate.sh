#!/bin/bash

validate_all() {
  if [ "$#" -ne 0 ]; then
    echo "Error: Too many arguments" >&2
    exit 1
  fi

  if ! command -v goaccess >/dev/null 2>&1 ; then
    echo "Error: goaccess is not installed. Run: sudo apt install -y goaccess" >&2
    exit 1
  fi

  if ! compgen -G "$DIR/../04/*.log" >/dev/null; then
    echo "Error: Log files not found." >&2
    exit 1
  fi
}