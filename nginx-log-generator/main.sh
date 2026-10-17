#!/bin/bash

#200 — OK (успешный запрос)
#201 — Created (успешно создан новый ресурс)
#400 — Bad Request (синтаксическая ошибка в запросе клиента)
#401 — Unauthorized (требуется аутентификация)
#403 — Forbidden (доступ запрещен сервером)
#404 — Not Found (запрашиваемый ресурс не найден)
#500 — Internal Server Error (внутренняя непредвиденная ошибка сервера)
#501 — Not Implemented (сервер не поддерживает функционал для обработки запроса)
#502 — Bad Gateway (сервер-шлюз получил недопустимый ответ от вышестоящего сервера)
#503 — Service Unavailable (сервер временно перегружен или на техработах)

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/validate.sh"
source "$DIR/generator.sh"

validate_arg "$@"

for day in {1..5}; do
  generate_log "$day" "$DIR/nginx_${day}.log"
done