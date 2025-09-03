markdown
# Recovery Guide — VPN Infrastructure

## 1. Развернуть чистые VM

- CA: `openvpn-ca_1.0-1_all.deb`
- VPN-сервер: `vpn-server_1.0-1_all.deb`
- Monitoring: `vpn-monitor_1.0-1_all.deb`
- Backup: `vpn-backup_1.0-1_all.deb`

## 2. Установить пакеты

```bash
sudo dpkg -i debs/openvpn-ca_1.0-1_all.deb
sudo dpkg -i debs/vpn-server_1.0-1_all.deb
Восстановить из backup
bash
sudo bash scripts/vpn-restore.sh /opt/vpn-backups/vpn-YYYY-MM-DD-HHMM/
Проверить
bash
ip a | grep tun0
curl localhost:9090/api/v1/alerts
curl localhost:9100/metrics
