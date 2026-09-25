#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/validate.sh"
source "$DIR/generator.sh"
source "$DIR/create.sh"

validate_args "$@"
start_time="$(date +'%Y-%m-%d %H:%M:%S')"
start_sec=$(date +%s)

creation "$1" "$2" "$3"

end_time="$(date +'%Y-%m-%d %H:%M:%S')"
end_sec=$(date +%s)
duration=$(awk -v start="$start_sec" -v end="$end_sec" 'BEGIN { printf "%.2f\n", end - start}')
log_file="$(pwd)/file.log"
{
echo "START TIME: $start_time"
echo "END TIME: $end_time"
echo "Script execution time: $duration"
} | tee -a "$log_file"