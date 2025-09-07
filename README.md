# VPN Final Project — Reproducible Infrastructure

---

## Назначение

Проект реализует полностью воспроизводимую VPN-инфраструктуру, оформленную в виде DEB-пакетов и сопровождаемую пошаговой документацией. Все артефакты валидированы, процессы автоматизированы, handoff готов.

---

## Быстрая установка

```bash
sudo bash scripts/vpn-setup.sh
	DEB-пакеты
Пакет
Назначение
openvpn-ca
PKI и CA
vpn-server
Сервер OpenVPN
vpn-client
Клиент OpenVPN
vpn-monitor
Prometheus + Alertmanager шаблоны
vpn-backup
Backup/restore скрипты
Все пакеты устанавливаются через dpkg -i, содержат postinst-скрипты и логируют действия в syslog.
	Структура проекта
plaintext
vpn-final-project/
├── debs/                          # DEB-пакеты
│   ├── openvpn-ca_1.0-1_all.deb
│   ├── vpn-backup_1.0-1_all.deb
│   ├── vpn-client_1.0-1_all.deb
│   ├── vpn-monitor_1.0-1_all.deb
│   └── vpn-server_1.0-1_all.deb

├── handoff/                       # Артефакты для передачи
│   ├── Handoff.md                 # Финальный гайд
│   ├── backup-plan.md            # План резервного копирования
│   ├── dataflow.md               # Потоки данных
│   ├── monitoring-config.tar.gz  # Конфигурация Prometheus
│   ├── recovery.md               # Восстановление инфраструктуры
│   ├── roadmap.md                # План развития
│   ├── screenshots.md            # Описание скриншотов мониторинга
│   └── user_guide.md             # Подключение клиента

├── scripts/                       # Скрипты установки и валидации
│   ├── build-client.sh
│   ├── post-deploy-validate.sh
│   ├── validate-client.sh
│   ├── validate-ssh.sh
│   ├── vpn-backup.sh
│   ├── vpn-restore.sh
│   └── vpn-setup.sh

├── validation-screenshots/        # Скриншоты VPN, мониторинга и алертов
│   ├── alert_highload_firing_rescue-vm.png
│   ├── config_alert_highload_rescue-vm_.png
│   ├── ip-after-vpn-rescue-vm.png
│   ├── ip-before-vpn-rescue-vm.png
│   ├── iptables_rule_9100.png
│   ├── node-exporter-metrics-another-vm.png
│   ├── node-exporter-metrics-rescue-vm.png
│   ├── node_exporter_metrics.png
│   ├── openvpn-exporter-metrics-another-vm.png
│   ├── openvpn-exporter-metrics-another-vm1.png
│   ├── prometheus-active-alerts-rescue-vm.png
│   ├── prometheus-alert-rules-rescue-vm.png
│   ├── prometheus-alertmanager-connected.png
│   ├── prometheus-metrics-another-vm.png
│   ├── prometheus-status-output.png
│   ├── prometheus-targets-rescue-vm.png
│   ├── prometheus_ready_check.png
│   ├── prometheus_yml_config.png
│   ├── vpn-after-connect.png
│   ├── vpn-client-conf.png
│   ├── vpn-client-started-rescue-vm.png
│   ├── vpn-server-conf.png
│   └── vpn-server-status.png

└── README.md                      # Этот файл

	Установка вручную (если не используется vpn-setup.sh)
bash
sudo dpkg -i debs/openvpn-ca_1.0-1_all.deb
sudo dpkg -i debs/vpn-server_1.0-1_all.deb
sudo dpkg -i debs/vpn-client_1.0-1_all.deb
sudo dpkg -i debs/vpn-monitor_1.0-1_all.deb
sudo dpkg -i debs/vpn-backup_1.0-1_all.deb
	Скрипты
Скрипт	Назначение
vpn-setup.sh	Полная установка всех компонентов
build-client.sh	Генерация .ovpn конфигурации
validate-client.sh	Проверка структуры .ovpn, ключей и сертификатов
vpn-backup.sh	Создание резервной копии, добавление .norestore
vpn-restore.sh	Восстановление из резервной копии
validate-ssh.sh	Проверка SSH-ключа, git remote, доступа к GitHub
post-deploy-validate.sh	Финальная проверка инфраструктуры

	Документация и handoff
Полный гайд по установке, проверке, восстановлению и передаче проекта:
plaintext
handoff/Handoff.md
Содержит:
    • Назначение проекта
    • Установку и скрипты
    • Backup и recovery
    • Потоки данных
    • Скриншоты и мониторинг
    • Финальную структуру handoff
	Проверка после установки
bash
ip a | grep tun0
curl ifconfig.me
curl localhost:9090/api/v1/alerts
curl localhost:9100/metrics
curl localhost:9176/metrics
	Статус
    • Все компоненты установлены и валидированы
    • Скрипты отказоустойчивы, логируют в syslog
    • Документация handoff завершена
    • Артефакты готовы к передаче
    • Проект воспроизводим, handoff-готов
