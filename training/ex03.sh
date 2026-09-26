#!/bin/bash

if [ "$#" -ne 2 ]; then
   echo "Error: Two arguments"
   exit 1
fi


if (( "$1" > "$2" )); then
   echo "Fail"
   exit 1
   else 
    for (( i="$1"; i<="$2"; i++ )); do
      echo "$i"
    done
fi