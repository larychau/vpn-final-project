# Handoff Guide — VPN Final Project

## Назначение

Этот документ описывает порядок развертывания, проверки и восстановления VPN-инфраструктуры. Все действия автоматизированы, воспроизводимы и сопровождаются артефактами.

---

## 1. Установка DEB-пакетов

```bash
sudo dpkg -i debs/openvpn-ca_1.0-1_all.deb
sudo dpkg -i debs/vpn-server_1.0-1_all.deb
sudo dpkg -i debs/vpn-client_1.0-1_all.deb
sudo dpkg -i debs/vpn-monitor_1.0-1_all.deb
sudo dpkg -i debs/vpn-backup_1.0-1_all.deb
После установки убедитесь, что все postinst-скрипты отработали. Логи доступны в syslog.

2. Генерация и валидация клиента
bash
sudo bash scripts/build-client.sh
bash scripts/validate-client.sh
Ожидаемый результат: .ovpn-файл, ключи, сертификаты, команда для ручного запуска.

3. Проверка SSH и доступа к GitHub
bash
bash scripts/validate-ssh.sh
Ожидаемый результат: SSH-ключ найден, git remote корректен, доступ к GitHub подтверждён.

4. Мониторинг и алерты
Распаковать handoff/monitoring-config.tar.gz

Проверить targets:

bash
curl http://localhost:9090/api/v1/targets
Проверить алерты:

bash
curl http://localhost:9090/api/v1/alerts
curl http://localhost:9090/api/v1/rules
Проверить exporters:

bash
curl http://localhost:9100/metrics | head -n 20
curl http://localhost:9176/metrics | head -n 20
Скриншоты и команды — в handoff/screenshots.md Визуальные подтверждения — в validation-screenshots/

5. Резервное копирование
bash
bash scripts/vpn-backup.sh
Ожидаемый результат: резервная копия в ~/vpn-backups/vpn-YYYY-MM-DD-HHMM/, .norestore-маркер добавлен.

6. Восстановление
bash
bash scripts/vpn-restore.sh ~/vpn-backups/vpn-YYYY-MM-DD-HHMM/
Скрипт проверяет .norestore, требует подтверждение, логирует действия.

7. Проверка после развертывания
Рекомендуется запустить post-deploy-validate.sh (если добавлен), либо вручную:

Проверить VPN-интерфейс (ip a, curl ifconfig.me)

Проверить exporters и Prometheus

Проверить syslog на наличие ошибок

8. Артефакты
vpn-client-bundles/ — сгенерированные конфигурации

handoff/screenshots.md — описание всех скриншотов

handoff/monitoring-config.tar.gz — финальная конфигурация Prometheus

validation-screenshots/ — визуальные подтверждения

scripts/ — все скрипты генерации, валидации, backup/restore

9. Требования
OpenVPN (sudo apt install openvpn)

Git (sudo apt install git)

SSH-ключ, добавленный в GitHub

Права sudo для доступа к логам и сетевым интерфейсам
