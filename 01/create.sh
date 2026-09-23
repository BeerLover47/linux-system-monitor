#!/bin/bash

check_free_space() {
    local free_mb=$(df --output=avail -m / | tail -n 1)

    if [ "$free_mb" -le 1024 ]; then
        echo "Attention: there is less than 1GB of space left on the disk" >&2
        return 1
    fi
    return 0
}

creation() {
    local base_dir="$1"
    local folders_count="$2"
    local folder_letters="$3"
    local files_count="$4"
    local file_chars="$5"
    local file_size="$6"
    local log_file="$(pwd)/file.log"

    local file_name_letters=${file_chars%.*}
    local file_ext=${file_chars#*.}
    local size_kb=${file_size%[kK][bB]}

    for (( i=1; i<=folders_count; i++ )); do
        if ! check_free_space; then
        return 1
        fi

        local folder_name=$(generate_folder_name "$folder_letters" "$i")
        mkdir -p "$base_dir/$folder_name"
        local folder_path="$base_dir/$folder_name"
        echo "$folder_path $(date '+%Y-%m-%d %H:%M:%S')" >> "$log_file"

        for (( j=1; j<=files_count; j++ )); do
            if ! check_free_space; then
            return 1
            fi
            local file_name=$(generate_file_name "$file_name_letters" "$file_ext" "$j")
            local file_path="$folder_path/$file_name"
            fallocate -l "${size_kb}K" "$file_path"
            echo "$file_path $(date '+%Y-%m-%d %H:%M:%S') $file_size" >> "$log_file"
        done
    done
}