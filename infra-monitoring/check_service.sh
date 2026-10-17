#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

check_status() {
    local status="$1"
    if [ "$status" = "active" ]; then
      echo -e "${GREEN}[ACTIVE]${RESET}"
    else
      echo -e "${RED}[INACTIVE]${RESET}"
    fi
}

check_services() {
    local prometheus=$(systemctl is-active prometheus 2>/dev/null)
    local node_exporter=$(systemctl is-active prometheus-node-exporter 2>/dev/null)
    local grafana=$(systemctl is-active grafana-server 2>/dev/null)
    local prometheus_status=$(check_status "$prometheus")
    local node_exporter_status=$(check_status "$node_exporter")
    local grafana_status=$(check_status "$grafana")

    echo -e "Prometheus: $prometheus_status :9090 | Node Exporter: $node_exporter_status :9100 | Grafana: $grafana_status :3000"
}