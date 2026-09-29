#!/bin/bash

mode1_code_answer() {
  awk '{print $0}' "$@" | sort -k9,9n
}

mode2_ip() {
  awk '!seen[$1]++ {print $1}' "$@"
}

mode3_errors() {
  awk '$9 ~ /^[45][0-9]{2}$/ {print $0}' "$@"
}

mode4_unique_ip() {
  awk '($9 ~ /^[45][0-9]{2}$/) && !seen[$1]++ {print $1}' "$@"
}