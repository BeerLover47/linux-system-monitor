#!/bin/bash
#check six argument
if [ $# -ne 6 ]; then
    echo "Error: Six arguments are expected."
    exit 1
fi
#argument ends with "/"
if [[ "$1" =~ /$ ]]; then
    echo "Error: Directory path must end with "/"."
    exit 1
fi
#check arguments 2 and 4
if [[ "$2" =~ ^-[0-9]+$ || "$4" =~ ^-[0-9]+$ ]]; then
    echo "Error: Arguments 2 and 4 must be positive integers."
    exit 1
fi
#check kb and max size 100 kb

