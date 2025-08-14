VPN Final Project
Проект предназначен для генерации, проверки, резервного копирования и восстановления OpenVPN клиентских конфигураций. Все процессы автоматизированы и воспроизводимы.

Структура проекта
Code
vpn-final-project/
├── scripts/
│   ├── build-client.sh
│   ├── vpn-backup.sh
│   ├── vpn-restore.sh
│   ├── validate-client.sh
│   └── validate-ssh.sh
├── vpn-client-bundles/
│   └── client.ovpn + ключи/сертификаты
├── vpn-docs/
│   └── README.md
Требования
OpenVPN (sudo apt install openvpn)

Git (sudo apt install git)

SSH-ключ, добавленный в GitHub

Права sudo для доступа к логам и сетевым интерфейсам

Скрипты
build-client.sh
Генерирует .ovpn конфигурацию для клиента OpenVPN.

bash
sudo bash scripts/build-client.sh
validate-client.sh
Проверяет наличие .ovpn, ключей и сертификатов. Валидирует структуру и выводит команду для ручного запуска.

bash
bash scripts/validate-client.sh
vpn-backup.sh
Создаёт резервную копию клиентских конфигураций, логов и документации. Добавляет .norestore маркер.

bash
bash scripts/vpn-backup.sh
Резервные копии сохраняются в ~/vpn-backups/vpn-YYYY-MM-DD-HHMM/

vpn-restore.sh
Восстанавливает данные из указанной резервной копии. Проверяет .norestore и требует подтверждение.

bash
bash scripts/vpn-restore.sh ~/vpn-backups/vpn-2025-08-14-2130
validate-ssh.sh
Проверяет наличие SSH-ключа, корректность git remote, и доступ к GitHub.

bash
bash scripts/validate-ssh.sh
Порядок запуска
Сгенерировать конфигурацию:

bash
sudo bash scripts/build-client.sh
Проверить структуру:

bash
bash scripts/validate-client.sh
Сделать резервную копию:

bash
bash scripts/vpn-backup.sh
Проверить SSH-доступ:

bash
bash scripts/validate-ssh.sh
При необходимости — восстановить:

bash
bash scripts/vpn-restore.sh <путь_к_бэкапу>
