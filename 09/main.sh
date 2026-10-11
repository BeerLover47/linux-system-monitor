#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/validate.sh"
source "$DIR/metrics.sh"

validate_arg "$@"

while true; do
  generate_metrics_page
  sleep 3
done
