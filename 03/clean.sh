#!/bin/bash

clean_by_log() {
  echo "Cleanup method 1: by log file"

  read -p "Enter path to log file: " log_file
  if [ ! -f "$log_file" ]; then
    echo "Error: File not found" >&2
    exit 1
  fi

  local count=0
  while IFS= read -r line; do
    read -r target_path _ <<< "$line"
    if [[ "$target_path" =~ ^/ ]] && [ "$target_path" != "/" ] && [ -e "$target_path" ]; then
      rm -rf "$target_path"
    (( count++ ))
    echo "$count: $line"
    fi
  done < "$log_file"
  echo "Total deleted: $count object."
}

clean_by_time() {
  echo "Cleanup method 2: by creation date/time"
  
  read -r -p "Enter start time (YYYY-MM-DD HH:MM): " start_date
  read -r -p "Enter end time (YYYY-MM-DD HH:MM): " end_date
  
  local ts_start=$(date -d "$start_date" +%s 2>/dev/null)
  local ts_end=$(date -d "$end_date" +%s 2>/dev/null)

  if [ -z "$ts_start" ] || [ -z "$ts_end" ]; then
    echo "Error: Invalid format" >&2
    exit 1
  fi

  if [[ $ts_end -lt $ts_start ]]; then
    echo "Error: End time cannot be earlier than start time" >&2
    exit 1
  fi

  local find_start="${start_date}:00"
  local find_end="${end_date}:59"

  while IFS= read -r target; do
    if [ -e "$target" ]; then
      rm -rf "$target"
      echo "Deleted: $target"
    fi
  done < <(find / -maxdepth 6 \
    \( -path '/proc' -o -path '/sys' -o -path '/dev' -o -path '/run' -o -path '/bin' -o -path '/sbin' -o -path '/mnt' -o -path '/media' \) -prune \
    -o -newermt "$find_start" ! -newermt "$find_end" -name "*_[0-9][0-9][0-9][0-9][0-9][0-9]*" -print 2>/dev/null)
}

# ------------------------------------------------------------------------------
# Способ 3: Очистка по маске имени (символы, _ и дата DDMMYY)
# ------------------------------------------------------------------------------
# 📖 Где смотреть в гайде:
#   - DO4_GUIDE.md -> Раздел 2.6, пункт 1 и 3 ("find, исключение системных веток и порядок обхода")
# 💡 Где ты это уже делал:
#   - 01/ и 02/ (вспоминай, как формировались имена: *_DDMMYY)
#   - training/ex01.sh (маска даты DDMMYY)
# 🔍 Намёк на синтаксис find:
#   find /каталог -name "*_DDMMYY" (или regex по дате)
# ------------------------------------------------------------------------------
clean_by_mask() {
  echo "Cleanup method 3: by name mask"
  # TODO:
  # 1. Запросить у пользователя маску даты (например, 260926) или полную маску
  # 2. Найти объекты через find по имени: find ... -name "*_${date_mask}"
  # 3. Удалить найденные объекты
}
