#!/bin/bash
set -e
trap 'echo "[!] Ошибка на строке $LINENO"; exit 1' ERR

echo "[+] Установка пакетов"
sudo dpkg -i debs/openvpn-ca_1.0-1_all.deb
sudo dpkg -i debs/vpn-server_1.0-1_all.deb
sudo dpkg -i debs/vpn-client_1.0-1_all.deb
sudo dpkg -i debs/vpn-monitor_1.0-1_all.deb
sudo dpkg -i debs/vpn-backup_1.0-1_all.deb

echo "[+] Генерация клиента"
sudo bash scripts/build-client.sh igor

echo "[+] Проверка клиента"
bash scripts/validate-client.sh

echo "[+] Проверка VPN-интерфейса"
ip a | grep tun0 || echo "[!] Интерфейс tun0 не найден"

echo "[+] Проверка внешнего IP"
curl ifconfig.me || echo "[!] Не удалось получить внешний IP"

echo "[+] Готово"
