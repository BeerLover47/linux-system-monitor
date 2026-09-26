#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Error: One argument"
  exit 1
fi

log_parser() {
  read -r log_path log_date log_time log_size <<< "$1"
  

}