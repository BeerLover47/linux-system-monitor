#!/bin/bash

cpu_usage() {
    top -bn1 | grep "Cpu" | tr ',' ' ' | awk '{print 100 - $8}'
}
mem_available() {
    awk '/MemAvailable:/ {print $2 * 1024}' /proc/meminfo
}
disk_available() {
    df --output=avail -B1 / | tail -n 1
}
generate_metrics_page(){
    local target_file="${1:-/var/www/html/metrics.html}"
    local cpu=$(cpu_usage)
    local mem=$(mem_available)
    local disk=$(disk_available)

    local tmp_file="${target_file}.tmp"
    
    cat <<EOF > "$tmp_file"
# HELP cpu_usage_percent CPU usage in percent
# TYPE cpu_usage_percent gauge
cpu_usage_percent $cpu

# HELP mem_available_bytes Available RAM in bytes
# TYPE mem_available_bytes gauge
mem_available_bytes $mem

# HELP disk_available_bytes Available disk space on root filesystem in bytes
# TYPE disk_available_bytes gauge
disk_available_bytes $disk
EOF

    mv "$tmp_file" "$target_file"
}