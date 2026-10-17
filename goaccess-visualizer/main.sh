#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/validate.sh"

validate_all "$@"

goaccess "$DIR/../nginx-log-generator/"*.log --log-format=COMBINED -o "$DIR/report.html"
echo "Report generated: $DIR/report.html"
