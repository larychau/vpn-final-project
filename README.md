VPN Final Project — Reproducible Infrastructure

Назначение

Проект содержит полностью воспроизводимую VPN-инфраструктуру, оформленную в виде DEB-пакетов и сопровождаемую пошаговой документацией. Все артефакты валидированы, процессы автоматизированы, handoff готов.

                        Быстрая установка

bash
sudo bash scripts/vpn-setup.sh

                        DEB-пакеты
Пакет	                                Назначение
openvpn-ca	                    PKI и CA
vpn-server	                    Сервер OpenVPN
vpn-client	                    Клиент OpenVPN
vpn-monitor	                    Prometheus + Alertmanager шаблоны
vpn-backup	                    Backup/restore скрипты
Все пакеты устанавливаются через dpkg -i, содержат postinst-скрипты и логируют действия в syslog.

                        Структура проекта
vpn-final-project/
├── debs/                      # DEB-пакеты
├── scripts/                   # Скрипты генерации, валидации и восстановления
├── vpn-client-bundles/        # Сгенерированные .ovpn + ключи/сертификаты
├── vpn-docs/                  # Документация по блокам
│   ├── 00_Handoff/            # Финальный handoff
│   ├── 01_CA/                 # PKI и CA
│   ├── 02_Server/             # VPN-сервер
│   ├── 03_Client/             # VPN-клиент
│   ├── 04_Monitoring/         # Мониторинг
│   └── 05_Backup/             # Резервное копирование
├── handoff/                   # Артефакты для передачи
│   ├── Handoff.md             # Финальный гайд
│   ├── user_guide.md          # Подключение клиента
│   ├── recovery.md            # Восстановление инфраструктуры
│   ├── backup-plan.md         # План резервного копирования
│   ├── infrastructure-diagram.png # Схема компонентов
│   ├── dataflow.md            # Потоки данных
│   ├── screenshots.md         # Описание всех скриншотов мониторинга
│   └── monitoring-config.tar.gz # Финальная конфигурация Prometheus
├── validation-screenshots/    # Скриншоты VPN, мониторинга и алертов
├── roadmap.md                 # План развития
└── README.md                  # Этот файл

                        Установка вручную (если не используется vpn-setup.sh)
bash
sudo dpkg -i debs/openvpn-ca_1.0-1_all.deb
sudo dpkg -i debs/vpn-server_1.0-1_all.deb
sudo dpkg -i debs/vpn-client_1.0-1_all.deb
sudo dpkg -i debs/vpn-monitor_1.0-1_all.deb
sudo dpkg -i debs/vpn-backup_1.0-1_all.deb

                        Скрипты
Скрипт	                                Назначение
vpn-setup.sh	               Полная установка всех компонентов (обёртка)
build-client.sh	               Генерация .ovpn конфигурации
validate-client.sh	           Проверка структуры .ovpn, ключей и сертификатов
vpn-backup.sh	               Создание резервной копии, добавление .norestore
vpn-restore.sh	               Восстановление из резервной копии
validate-ssh.sh	               Проверка SSH-ключа, git remote, доступа к GitHub

                        Валидация и handoff
Все скриншоты мониторинга и алертов описаны в handoff/screenshots.md
Финальная конфигурация Prometheus: handoff/monitoring-config.tar.gz
Скриншоты VPN, exporters и алертов: validation-screenshots/

                        Документация handoff
Файл	                                                            Назначение
handoff/Handoff.md	                                    Финальный гайд по установке и проверке
handoff/user_guide.md	                                Инструкция для подключения клиента
handoff/recovery.md	                                    Сценарий полного восстановления
handoff/backup-plan.md	                                Что и как бэкапим
handoff/dataflow.md	                                    Потоки данных в инфраструктуре
handoff/infrastructure-diagram.png	                    Схема компонентов

                        Проверка

bash
ip a | grep tun0
curl ifconfig.me
curl localhost:9090/api/v1/alerts
curl localhost:9100/metrics
curl localhost:9176/metrics
