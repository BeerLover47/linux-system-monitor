#!/bin/bash

validate_arg() {
if [ "$#" -ne 0 ]; then
   echo "Error: Too many arguments" >&2
   exit 1
fi

if ! command -v iperf3 >/dev/null 2>&1; then
   echo "Error: iperf3 is not installed" >&2
   exit 1
fi
}