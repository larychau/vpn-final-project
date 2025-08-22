# VPN Final Project — Reproducible Infrastructure

## Назначение

Проект содержит полностью воспроизводимую VPN-инфраструктуру, оформленную в виде deb-пакетов и сопровождаемую пошаговой документацией. Все артефакты валидированы, процессы автоматизированы, handoff готов.

## DEB-пакеты

| Пакет           | Назначение                        |
|------------------|-----------------------------------|
| `openvpn-ca`     | PKI и CA                          |
| `vpn-server`     | Сервер OpenVPN                    |
| `vpn-client`     | Клиент OpenVPN                    |
| `vpn-monitor`    | Prometheus + Alertmanager шаблоны |
| `vpn-backup`     | Backup/restore скрипты            |

Все пакеты устанавливаются через `dpkg -i`, содержат `postinst`-скрипты и логируют действия в `syslog`.

## Структура проекта

vpn-final-project/ ├── debs/ # DEB-пакеты ├── scripts/ # Скрипты генерации, валидации и восстановления ├── vpn-client-bundles/ # Сгенерированные .ovpn + ключи/сертификаты ├── vpn-docs/ # Документация по блокам │ ├── 00_Handoff/ # Финальный handoff │ ├── 01_CA/ # PKI и CA │ ├── 02_Server/ # VPN-сервер │ ├── 03_Client/ # VPN-клиент │ ├── 04_Monitoring/ # Мониторинг │ └── 05_Backup/ # Резервное копирование ├── handoff/ │ ├── screenshots.md # Описание всех скриншотов мониторинга │ └── monitoring-config.tar.gz # Финальная конфигурация Prometheus ├── validation-screenshots/ # Скриншоты валидации VPN, мониторинга и алертов └── README.md

## Установка

```bash
sudo dpkg -i debs/openvpn-ca_1.0-1_all.deb
sudo dpkg -i debs/vpn-server_1.0-1_all.debСкрипты
build-client.sh — генерирует .ovpn конфигурацию

bash
sudo bash scripts/build-client.sh
validate-client.sh — проверяет структуру .ovpn, ключей и сертификатов

bash
bash scripts/validate-client.sh
vpn-backup.sh — создаёт резервную копию, добавляет .norestore

bash
bash scripts/vpn-backup.sh
vpn-restore.sh — восстанавливает из указанной резервной копии

bash
bash scripts/vpn-restore.sh ~/vpn-backups/vpn-YYYY-MM-DD-HHMM/
validate-ssh.sh — проверяет SSH-ключ, git remote, доступ к GitHub

bash
bash scripts/validate-ssh.sh
Валидация и handoff
Все скриншоты мониторинга и алертов описаны в handoff/screenshots.md

Финальная конфигурация Prometheus: handoff/monitoring-config.tar.gz

Скриншоты VPN, exporters и алертов: validation-screenshots/
sudo dpkg -i debs/vpn-client_1.0-1_all.deb
sudo dpkg -i debs/vpn-monitor_1.0-1_all.deb
sudo dpkg -i debs/vpn-backup_1.0-1_all.deb
