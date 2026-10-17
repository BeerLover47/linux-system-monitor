#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/validate.sh"
source "$DIR/clean.sh"

validate_args "$@"

case "$1" in
  1)
    clean_by_log
    ;;
  2)
    clean_by_time
    ;;
  3)
    clean_by_mask
    ;;
  *)
    echo "Error: Unknown cleanup method '$1'" >&2
    exit 1
    ;;
esac
