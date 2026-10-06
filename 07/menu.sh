#!/bin/bash

context_menu() {
    while true; do
      echo ""
      echo "===== Test management menu ====="
      echo "1) Run stress-test CPU / RAM (stress)"
      echo "2) Run test disk (Part 2)"
      echo "3) Clear disk after disk test"
      echo "4) Get link for utilities"
      echo "5) Check services status"
      echo "0) Exit ^_^"

      read -rp "Choose action [0-5]: " choice
      case "$choice" in
        1)
        echo "Run stress"
        stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s
        ;;
        2)
        echo "Run test disk"
        "$DIR/../02/main.sh" az az.az 10Mb
        ;;
        3)
        echo ""
        echo "----- Choose cleaning method -----"
        echo "1) By Log File"
        echo "2) By date and time"
        echo "3) By mask name"
        read -rp "Cleaning mode [1-3]: " clean_mode
        "$DIR/../03/main.sh" "$clean_mode"
        ;;
        4)
        link
        ;;
        5)
        echo ""
        check_services
        ;;
        0)
        echo ""
        echo "Exit"
        break
        ;;
        *)
        echo ""
        echo -e "${RED}Please try again.${RESET}"
        ;;
      esac
    done       
}

link() {
    local IP="192.168.56.101"
    echo ""
    echo "----- Web UI Links -----"
    echo -e "http://${IP}:3000" "${GREEN}Grafana${RESET}"
    echo -e "http://${IP}:9090" "${GREEN}Prometheus${RESET}"
}
