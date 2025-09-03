# Скриншоты мониторинга и алертов

Документ фиксирует команды, хосты и цели для каждого скриншота, подтверждающего работу Prometheus, Alertmanager и экспортёров.

---

##  rescue-vm

### `prometheus-targets-rescue-vm.png`

- **Хост:** rescue-vm  
- **Команда:** `curl http://localhost:9090/api/v1/targets`  
- **Цель:** показать, что все targets `UP`  
- **Ожидаемый вывод:** JSON с `activeTargets`, `health: up`

---

### `prometheus-alert-rules-rescue-vm.png`

- **Хост:** rescue-vm  
- **Команда:** `curl http://localhost:9090/api/v1/rules`  
- **Цель:** показать, что алерт `HighLoad` загружен  
- **Ожидаемый вывод:** `state: inactive`, `health: ok`

---

### `prometheus-active-alerts-rescue-vm.png`

- **Хост:** rescue-vm  
- **Команда:** `curl http://localhost:9090/api/v1/alerts`  
- **Цель:** показать, что алерты отслеживаются  
- **Ожидаемый вывод:** пусто или активный алерт

---

### `prometheus-alertmanager-connected.png`

- **Хост:** rescue-vm  
- **Команда:** `curl http://localhost:9090/api/v1/alertmanagers`  
- **Цель:** показать, что Alertmanager подключён  
- **Ожидаемый вывод:** `activeAlertmanagers` → `http://localhost:9093`

---

### `node-exporter-metrics-rescue-vm.png`

- **Хост:** rescue-vm  
- **Команда:** `curl http://localhost:9100/metrics | head -n 20`  
- **Цель:** показать, что `node_exporter` работает  
- **Ожидаемый вывод:** метрики `go_gc_duration_seconds`, `node_load1`

---

### `prometheus-ui-targets.png`

- **Хост:** rescue-vm  
- **Действие:** открыть `http://localhost:9090/targets` в браузере  
- **Цель:** визуально подтвердить работу Prometheus  
- **Ожидаемый вывод:** список jobs, все `UP`

---

##  another-vm

### `node-exporter-another-vm.png`

- **Хост:** another-vm  
- **Команда:** `curl http://localhost:9100/metrics | head -n 20`  
- **Цель:** показать, что `node_exporter` работает  
- **Ожидаемый вывод:** метрики `go_gc_duration_seconds`, `node_load1`

---

### `openvpn-exporter-another-vm.png`

- **Хост:** another-vm  
- **Команда:** `curl http://localhost:9176/metrics | head -n 20`  
- **Цель:** показать, что `openvpn_exporter` работает  
- **Ожидаемый вывод:** `openvpn_connections`, `openvpn_bytes_sent`

---

### `prometheus-metrics-another-vm.png`

- **Хост:** another-vm  
- **Команда:** `curl http://localhost:9090/metrics | head -n 20`  
- **Цель:** показать, что Prometheus отдаёт метрики  
- **Ожидаемый вывод:** `go_gc_duration_seconds`, `prometheus_build_info`

---
### HighLoad (rescue-vm)

- Файл: `alert.rules.yml`
- Условие: `node_load1 > 1` в течение 1 минуты
- Хост: `rescue-vm`
- Проверка:

```bash
curl http://localhost:9090/api/v1/alerts
