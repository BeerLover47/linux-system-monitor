#!/bin/bash



DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/validate.sh"
source "$DIR/generator.sh"
source "$DIR/create.sh"

validate_args "$@"
creation "$@"
