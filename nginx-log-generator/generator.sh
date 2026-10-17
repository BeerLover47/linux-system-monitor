#!/bin/bash

methods=("GET" "POST" "PUT" "PATCH" "DELETE")
answers=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
urls=("/static/style.css" "/index.html" "/contacts" "/login" "/about")
referers=("-" "https://yandex.ru" "https://google.com")

generate_ip() {
    ip="$(( RANDOM % 254 + 1 )).$(( RANDOM % 256 )).$(( RANDOM % 256 )).$(( RANDOM % 254 + 1 ))"
    echo "$ip"
}

generate_log() {
  local day="$1"
  local file="$2"
  > "$file"

  local count=$(( RANDOM % 901 + 100 ))
  local current_time=$(date -d "today - $(( 6 - day )) days 00:00:00" +%s)
  local i
  for (( i=0; i < count; i++ )); do
    current_time=$(( current_time + (RANDOM % 55 + 5)))
    log_date=$(LC_ALL=C date -d "@$current_time" +"%d/%b/%Y:%H:%M:%S %z")
    ip=$(generate_ip)
    method=${methods[RANDOM % ${#methods[@]}]}
    url=${urls[RANDOM % ${#urls[@]}]}
    status=${answers[RANDOM % ${#answers[@]}]}
    bytes=$(( RANDOM % 5000 + 100 ))
    referer=${referers[RANDOM % ${#referers[@]}]}
    agent=${agents[RANDOM % ${#agents[@]}]}
    
    echo "$ip - - [$log_date] \"$method $url HTTP/1.1\" $status $bytes \"$referer\" \"$agent\"" >> "$file"
  done
}