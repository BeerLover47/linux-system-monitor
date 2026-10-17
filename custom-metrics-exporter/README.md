# 📡 Native Bash Metrics Exporter (`custom-metrics-exporter`)

Легковесный кастомный экспортер системных метрик на чистом Bash без внешних зависимостей. Формирует метрики в стандарте **Prometheus OpenMetrics** и раздаёт их через HTTP-сервер Nginx.

---

## 🚀 Использование

```bash
./main.sh
```

Скрипт переходит в циклический режим: каждые 3 секунды собирает актуальные метрики системы и атомарно записывает их в HTML/текстовый корень Nginx (по умолчанию `/var/www/html/metrics` или файл в текущей директории).

### Проверка отдачи метрик:
```bash
curl -s http://localhost/metrics
```

*Пример вывода Prometheus-совместимых метрик:*
```text
# HELP my_cpu_usage Current CPU usage in percent
# TYPE my_cpu_usage gauge
my_cpu_usage 14.5

# HELP my_mem_free Free memory in bytes
# TYPE my_mem_free gauge
my_mem_free 842104832

# HELP my_disk_free Free disk space in bytes
# TYPE my_disk_free gauge
my_disk_free 24510488576
```

---

## ⚙️ Под капотом

* **Чтение напрямую из `/proc` (Zero Dependencies):**  
  Скрипт не использует тяжелые сторонние утилиты, а считывает состояние ядра напрямую из виртуальной файловой системы:
  * Процессор: расчёт дельты джиффисов (jiffies) между итерациями из `/proc/stat`.
  * Память: выборка полей `MemAvailable` и `MemTotal` из `/proc/meminfo`.
  * Нагрузка: системные средние из `/proc/loadavg`.
* **Атомарная запись (Atomic File Replacement):**  
  Чтобы Nginx не отдавал клиенту наполовину записанный файл метрик в момент генерации, запись выполняется во временный файл с последующим атомарным `mv`:
  ```bash
  generate_metrics > "${target}.tmp" && mv -f "${target}.tmp" "$target"
  ```
* **Интеграция с Prometheus:**  
  В конфигурацию `prometheus.yml` достаточно добавить новый таргет:
  ```yaml
  scrape_configs:
    - job_name: 'bash_custom_exporter'
      scrape_interval: 3s
      static_configs:
        - targets: ['localhost:80']
  ```

