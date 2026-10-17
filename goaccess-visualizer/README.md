# 📊 Visual Web Analytics (`goaccess-visualizer`)

Интерактивная визуализация веб-трафика и аналитика логов Nginx через GoAccess с генерацией автономного HTML-отчёта.

---

## 🚀 Использование

```bash
./main.sh
```

Скрипт проверяет наличие логов в `../nginx-log-generator/`, считывает все доступные `nginx_*.log` и генерирует автономный файл отчёта:
```
Report generated: ./report.html
```

Файл `report.html` содержит интерактивные графики, таблицы запросов, статус-коды, географию IP и User-Agent агентов. Его можно открыть в любом браузере:
```bash
# В WSL2 / Ubuntu:
xdg-open report.html || sensible-browser report.html
```

---

## ⚙️ Под капотом

* **Автоматическая проверка зависимостей:**  
  В `validate.sh` встроен предварительный чек наличия бинарника `goaccess` в системе:
  ```bash
  command -v goaccess >/dev/null 2>&1 || sudo apt install -y goaccess
  ```
* **Парсинг в Combined формате:**  
  Сборка отчёта запускается с явным указанием формата без необходимости правки глобального конфига `goaccess.conf`:
  ```bash
  goaccess "$DIR/../nginx-log-generator/"*.log --log-format=COMBINED -o "$DIR/report.html"
  ```
* **Терминальный интерактивный режим (TUI):**  
  При необходимости интерактивного мониторинга в реальном времени утилиту можно запустить прямо в консоли:
  ```bash
  goaccess ../nginx-log-generator/nginx_1.log --log-format=COMBINED
  ```

