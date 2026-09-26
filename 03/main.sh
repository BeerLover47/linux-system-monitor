#!/bin/bash

# ==============================================================================
# ДИСПЕТЧЕР ОЧИСТКИ ФАЙЛОВОЙ СИСТЕМЫ (PART 3)
# ------------------------------------------------------------------------------
# 📖 Где смотреть в гайде:
#   - DO4_GUIDE.md -> Раздел 1.1 "Модульная декомпозиция и точка входа"
#   - DO4_GUIDE.md -> Раздел 1.2 "Определение пути через BASH_SOURCE"
#   - DO4_GUIDE.md -> Раздел 1.3 "Подключение модулей через source"
# 💡 Где ты это уже делал:
#   - 02/main.sh (импорт validate.sh, create.sh, generator.sh)
#   - training/ex07.sh (диспетчер команд case ... in)
# ==============================================================================

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/validate.sh"
source "$DIR/clean.sh"

validate_args "$@"

case "$1" in
  1)
    clean_by_log
    ;;
  2)
    clean_by_time
    ;;
  3)
    clean_by_mask
    ;;
  *)
    echo "Error: Unknown cleanup method '$1'" >&2
    exit 1
    ;;
esac
