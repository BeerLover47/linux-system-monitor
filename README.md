# 🐧 Linux System Monitor (DO4)

<p align="center">
  <img src="https://img.shields.io/badge/Bash-5.2%2B-1E232A?style=for-the-badge&logo=gnu-bash&logoColor=4EAA25&labelColor=161B22" alt="Bash"/>
  <img src="https://img.shields.io/badge/Ubuntu-24.04_LTS-1E232A?style=for-the-badge&logo=ubuntu&logoColor=E95420&labelColor=161B22" alt="Ubuntu"/>
  <img src="https://img.shields.io/badge/Prometheus-v2.54%2B-1E232A?style=for-the-badge&logo=prometheus&logoColor=E6522C&labelColor=161B22" alt="Prometheus"/>
  <img src="https://img.shields.io/badge/Grafana-v11%2B-1E232A?style=for-the-badge&logo=grafana&logoColor=F46800&labelColor=161B22" alt="Grafana"/>
  <img src="https://img.shields.io/badge/Nginx-1.24%2B-1E232A?style=for-the-badge&logo=nginx&logoColor=009639&labelColor=161B22" alt="Nginx"/>
  <img src="https://img.shields.io/badge/School_21-DO4_100%25-00873E?style=for-the-badge&labelColor=161B22" alt="School 21"/>
</p>

Проект по системному администрированию и мониторингу Linux (School 21, DO4 — сдан на 100%).

* **Автор:** Vladislav ([@BeerLover47](https://github.com/BeerLover47))
* **Ник в Школе 21:** `cecilqua`

---

## О чем проект

Писал скрипты на Bash под Ubuntu 24.04 LTS для автоматизации базовых задач сисадмина:

1. **Генерация и очистка файлов (части 01–03):** создание структуры папок и файлов по маске с помощью `fallocate`, заполнение диска с проверкой свободного места (скрипт останавливается при остатке меньше 1 Гб) и три способа очистки (по лог-файлу, по времени создания и по маске).
2. **Веб-логи и парсинг (части 04–06):** генератор логов Nginx в Combined Log Format, потоковый анализ логов через `awk` (сортировка по кодам ответа, поиск уникальных IP, фильтрация ошибок) и визуализация через GoAccess (в консоли и через HTML-отчет).
3. **Мониторинг инфраструктуры (части 07–09):** развертывание Prometheus + Node Exporter + Grafana, настройка дашбордов для CPU, памяти, диска и сети. Стресс-тесты через `stress` и сетевые замеры через `iperf3`. В 9-й части написан собственный Bash-экспортер метрик, отдающий данные через Nginx на `/metrics`.

Логику каждого задания разделял на небольшие файлы: проверка аргументов (`validate.sh`), генерация или фильтрация (`generator.sh` / `clean.sh`) и точка входа (`main.sh`).

---

## Структура папок

| Папка | Что делает | Утилиты и стек |
|:---:|:---|:---|
| `01` | Создание файлов и папок по алфавитной маске с фиксацией в `file.log` | `fallocate`, `df` |
| `02` | Заполнение диска файлами до порога свободного места в 1 Гб | Bash, `$RANDOM`, замер времени |
| `03` | Очистка созданных файлов: по логу, по времени создания или по маске | `find`, process substitution |
| `04` | Генерация 5 лог-файлов Nginx в Combined Log Format со случайными IP и кодами | Bash, Unix Epoch |
| `05` | Потоковый анализ логов через `awk` (сортировка, уникальные IP, фильтрация 4xx/5xx) | `awk`, `sort` |
| `06` | Интерактивная аналитика логов в GoAccess (TUI в терминале и HTML-отчет) | `goaccess` |
| `07` | Мониторинг ресурсов в Prometheus и Grafana, кастомный дашборд с 4 панелями | Prometheus, Node Exporter, Grafana |
| `08` | Готовый дашборд (ID 13978) и сетевой тест через `iperf3` | `iperf3`, Grafana, PromQL |
| `09` | Свой bash-экспортер метрик (CPU, RAM, диск) с отдачей через Nginx | Bash, Nginx, `rename(2)` |

---

## Руководство по запуску

Подробные команды запуска всех модулей, сценарии проверки и тестирования, а также шпаргалка по граблям лежат в:

👉 **[docs/guide.md](docs/guide.md)**
