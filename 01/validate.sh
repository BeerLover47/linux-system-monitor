#!/bin/bash


validate_args() {
if [ "$#" -ne 6 ]; then
    echo "Error: Six arguments are expected."
    exit 1
fi

if [[ ! "$1" =~ ^/ ]]; then
    echo "Error: Path must be absolute" >&2
    exit 1
fi

if [[ ! -d "$1" ]]; then
    echo "Error: Directory "$1" does not exist on the file system" >&2
    exit 1
fi

if [[ ! -w "$1" ]]; then
    echo "Error: No right to write to the directory "$1""
    exit 1
fi

num_regex='^[1-9][0-9]*$'
if [[ ! "$2" =~ $num_regex ]] || [[ ! "$4" =~ $num_regex ]]; then
    echo "Eror: Argument is a stricly natural number."
    exit 1
fi

letters_regex_arg3='^([a-zA-Z]{1,7})$'
if [[ ! "$3" =~ $letters_regex_arg3 ]]; then
    echo "Error: Argument "$3" must contain from 1 to 7 letters"
    exit 1
fi

letters_regex_arg5='^([a-zA-Z]{1,7})\.([a-zA-Z]{1,3})$'
if [[ ! "$5" =~ $letters_regex_arg5 ]]; then
    echo "Error: invalid format"
    exit 1
fi

size_kb='^([1-9]|[1-9][0-9]|100)[kK][bB]$'
if [[ ! "$6" =~ $size_kb ]]; then
    echo "Error: Size must be an integer from 1 to 100"
    exit 1
fi
}