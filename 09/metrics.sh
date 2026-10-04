#!/bin/bash

cpu_usage() {
    top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}'
}
mem_available() {
    awk '/MemAvailable:/ {print $2 * 1024}' /proc/meminfo
}
disk_available() {
    df --output=avail -B1 / | tail -n 1
}
generate_metrics_page(){
    target_file="$1"
    local cpu=$(cpu_usage)
    local mem=$(mem_available)
    local disk=$(disk_available)

    local tmp_file="${target_file}.tmp"
    
    cat <<EOF > "$tmp_file"
    # $cpu
    # $mem
    # $disk 
EOF

    mv "$tmp_file" "$target_file"
}