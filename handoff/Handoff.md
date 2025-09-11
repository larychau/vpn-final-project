# VPN Final Project — Handoff Guide

## Назначение

Этот документ описывает порядок развертывания, проверки, резервного копирования и восстановления VPN-инфраструктуры. Все действия автоматизированы, воспроизводимы и сопровождаются артефактами. Проект реализует PKI, OpenVPN, мониторинг, backup и CI/CD, оформленные в виде DEB-пакетов и скриптов.

---

## Установка DEB-пакетов

```bash
sudo dpkg -i debs/openvpn-ca_1.0-1_all.deb
sudo dpkg -i debs/vpn-server_1.0-1_all.deb
sudo dpkg -i debs/vpn-client_1.0-1_all.deb
sudo dpkg -i debs/vpn-monitor_1.0-1_all.deb
sudo dpkg -i debs/vpn-backup_1.0-1_all.deb
Все пакеты содержат postinst-скрипты и логируют действия в syslog.

Скрипты и порядок запуска
Шаг	Скрипт	Команда
Установка	vpn-setup.sh	sudo bash scripts/vpn-setup.sh
Генерация клиента	build-client.sh	sudo bash scripts/build-client.sh igor
Валидация клиента	validate-client.sh	bash scripts/validate-client.sh
Проверка SSH	validate-ssh.sh	bash scripts/validate-ssh.sh
Backup	vpn-backup.sh	bash scripts/vpn-backup.sh
Restore	vpn-restore.sh	bash scripts/vpn-restore.sh /opt/vpn-backups/vpn-YYYY-MM-DD-HHMM/
Финальная проверка	post-deploy-validate.sh	sudo bash scripts/post-deploy-validate.sh
Руководство пользователя VPN
Получите файл client-igor.ovpn из vpn-client-bundles/

Скопируйте его на клиентскую машину

Установите OpenVPN:

bash
sudo apt install openvpn
Подключитесь:

bash
sudo openvpn --config client-igor.ovpn
Проверьте IP:

bash
curl ifconfig.me
Мониторинг и алерты
Распаковка конфигурации
bash
tar -xzf handoff/monitoring-config.tar.gz
Проверка Prometheus
bash
curl http://localhost:9090/api/v1/targets
curl http://localhost:9090/api/v1/alerts
curl http://localhost:9090/api/v1/rules
Проверка exporters
bash
curl http://localhost:9100/metrics | head -n 20
curl http://localhost:9176/metrics | head -n 20
Скриншоты и команды — в handoff/screenshots.md Визуальные подтверждения — в validation-screenshots/

Схема потоков данных
Файл схемы включён в проект: handoff/System Data Flow Diagram.png

Схема визуализирует ключевые потоки:

CA → VPN-сервер → VPN-клиенты

Экспортеры → Prometheus → Alertmanager

Backup → Георепликация → Восстановление

План резервного копирования
Что бэкапим
PKI: ca.crt, ca.key, issued/, private/

VPN-конфиги: client.conf, server.conf

Monitoring: prometheus.yml, alert.rules.yml

Скрипты: vpn-backup.sh, vpn-restore.sh

Клиентские .ovpn: vpn-client-bundles/

Логи: /var/log/openvpn.log

Где хранится
bash
/opt/vpn-backups/vpn-YYYY-MM-DD-HHMM/
Как создать
bash
bash scripts/vpn-backup.sh
Как восстановить
bash
bash scripts/vpn-restore.sh /opt/vpn-backups/vpn-YYYY-MM-DD-HHMM/
Recovery Guide
Развернуть чистые VM:

CA: openvpn-ca_1.0-1_all.deb

VPN-сервер: vpn-server_1.0-1_all.deb

Monitoring: vpn-monitor_1.0-1_all.deb

Backup: vpn-backup_1.0-1_all.deb

Установить пакеты:

bash
sudo dpkg -i debs/openvpn-ca_1.0-1_all.deb
sudo dpkg -i debs/vpn-server_1.0-1_all.deb
Восстановить из backup:

bash
sudo bash scripts/vpn-restore.sh /opt/vpn-backups/vpn-YYYY-MM-DD-HHMM/
Проверить:

bash
ip a | grep tun0
curl localhost:9090/api/v1/alerts
curl localhost:9100/metrics
Скриншоты мониторинга
prometheus-targets-rescue-vm.png — targets UP

prometheus-alert-rules-rescue-vm.png — алерт HighLoad загружен

prometheus-active-alerts-rescue-vm.png — алерты отслеживаются

node-exporter-metrics-rescue-vm.png — метрики node_exporter

openvpn-exporter-another-vm.png — метрики openvpn_exporter

prometheus-ui-targets.png — визуальное подтверждение

alert.rules.yml — node_load1 > 1 в течение 1 минуты

Все команды, хосты и цели описаны в handoff/screenshots.md

План развития
CI/CD для DEB-пакетов

Geo-репликация backup-хранилища

Перенос скриптов в Ansible

HTTPS + Basic Auth для Prometheus

Telegram/Slack алерты

Terraform provisioning

Централизованное логирование

Onboarding-инструкции

Проверка сертификатов, алертов, логов через CI

Все задачи оформлены как action items с приоритетами и сроками

Артефакты handoff
handoff/Handoff.md — этот документ

handoff/user_guide.md — подключение клиента

handoff/recovery.md — восстановление

handoff/backup-plan.md — резервное копирование

handoff/dataflow.md — потоки данных

handoff/screenshots.md — мониторинг и алерты

handoff/monitoring-config.tar.gz — конфигурация Prometheus

handoff/System Data Flow Diagram.png — схема потоков данных

scripts/ — все скрипты установки, генерации, backup/restore

Статус
Все компоненты установлены и валидированы

Скрипты отказоустойчивы, логируют в syslog

Документация handoff завершена

Артефакты готовы к передаче

CI/CD и recovery-процедуры описаны

Проект воспроизводим, проверен, handoff-готов
