#!/bin/bash

validate_args() {
  if [ "$#" -ne 1 ];then
    echo "Error: One argument" >&2
    exit 1
  fi

  if [[ ! "$1" =~ ^[1-3]$ ]]; then
    echo "Error: One number from one to three" >&2
    exit 1
  fi
}