#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/validate.sh"
source "$DIR/filter.sh"

validate_arg "$@"

log_dir=$DIR/../04/
check_logs "$log_dir"
log_files=("$log_dir"/*.log)

case "$1" in
    1) mode1_code_answer "${log_files[@]}"
    ;;
    2) mode2_ip "${log_files[@]}"
    ;;
    3) mode3_errors "${log_files[@]}"
    ;;
    4) mode4_unique_ip "${log_files[@]}"
    ;;
    *)
    echo "Error: Unknown filer" >&2
    exit 1
    ;;
esac
