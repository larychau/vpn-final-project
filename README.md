<<<<<<< HEAD
# VPN Final Project — Reproducible Infrastructure

## Назначение

Проект содержит полностью воспроизводимую VPN-инфраструктуру, оформленную в виде deb-пакетов и сопровождаемую пошаговой документацией. Все артефакты валидированы, процессы автоматизированы, handoff готов.

---

##  DEB-пакеты

| Пакет         | Назначение                         |
|---------------|------------------------------------|
| openvpn-ca    | PKI и CA                           |
| vpn-server    | Сервер OpenVPN                     |
| vpn-client    | Клиент OpenVPN                     |
| vpn-monitor   | Prometheus + Alertmanager шаблоны |
| vpn-backup    | Backup/restore скрипты             |

Все пакеты устанавливаются через `dpkg -i`, содержат `postinst` скрипты и логируют действия в `syslog`.

---

##  Структура проекта

vpn-final-project/ ├── debs/ # DEB-пакеты ├── vpn-docs/ # Документация по блокам │ ├── 00_Handoff/ # Финальный handoff │ ├── 01_CA/ # PKI и CA │ ├── 02_Server/ # VPN-сервер │ ├── 03_Client/ # VPN-клиент │ ├── 04_Monitoring/ # Мониторинг │ └── 05_Backup/ # Резервное копирование

---

##  Установка

```bash
sudo dpkg -i debs/openvpn-ca_1.0-1_all.deb
sudo dpkg -i debs/vpn-server_1.0-1_all.deb
sudo dpkg -i debs/vpn-client_1.0-1_all.deb
sudo dpkg -i debs/vpn-monitor_1.0-1_all.deb
sudo dpkg -i debs/vpn-backup_1.0-1_all.deb
=======
cat <<EOF > README.md
# VPN Infrastructure — Финальная работа Skillbox

# Состав проекта

- Скрипты для настройки CA, VPN, мониторинга и бэкапа
- DEB-пакеты для автоматизации
- Документация для пользователей и админов
- Схемы и скриншоты
- План развития инфраструктуры

# Быстрый запуск

\`\`\`bash
sudo ./scripts/ca-init.sh
sudo ./scripts/vpn-setup.sh
sudo ./scripts/client-gen.sh igor
sudo ./scripts/monitoring-setup.sh
sudo ./scripts/backup.sh
\`\`\`

# Документация

- [Руководство пользователя VPN](docs/user_guide.md)
- [Руководство администратора](docs/admin_guide.md)
- [Проектирование мониторинга](docs/monitoring_design.md)
- [План резервного копирования](docs/backup_plan.md)
- [Roadmap развития](docs/roadmap.md)
EOF
>>>>>>> 1373098 (WIP: правки README и добавлен .gitignore)
