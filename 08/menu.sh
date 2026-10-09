#!/bin/bash

context_menu() {
    while true; do
    echo ""
    echo "===== Test menu ====="
    echo "1) Run test iperf3"
    echo "2) Run stress-test CPU/RAM"
    echo "3) Run test disk (Part 2)"
    echo "4) Clear dist after disk test"
    echo "5) Get link for utilities"
    echo "0) Exit [[_[]"

    read -rp "Choose action [0-5]: " choice
    IP=$(hostname -I | awk '{print $1}')
    IP="${IP:-127.0.0.1}"
    case "$choice" in
    1)
    read -rp "Enter target IP: " target_ip
    target_ip="${target_ip:-$IP}"
    iperf3 -c "$target_ip" -p 5201 -t 30 -P 4
    ;;
    2)
    echo "Run stress"
    stress -c 1 -i 1 -m 1 --vm-bytes 32M -t 10s
    ;;
    3)
    echo "Run test disk"
    "$DIR/../02/main.sh" az az.az 10Mb
    ;;
    4)
    echo ""
    echo "----- Choose cleaning method -----"
    echo "1) By Log File"
    echo "2) By date and time"
    echo "3) By mask name"
    read -rp "Cleaning mode [1-3]; " clean_mode
    "$DIR/../03/main.sh" "$clean_mode"
    ;;
    5)
    link
    ;;
    0)
    echo ""
    echo "Exit"
    break
    ;;
    *)
    echo ""
    echo "Please try again"
   esac
done
}

link() {
    echo ""
    echo "----- Web UI Links -----"
    echo "http://${IP}:3000" "Grafana"
    echo "http://${IP}:9090" "Prometheus"
}