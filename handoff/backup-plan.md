
```markdown
# План резервного копирования

## Что бэкапим

- PKI: `ca.crt`, `ca.key`, `issued/`, `private/`
- VPN-конфиги: `client.conf`, `server.conf`
- Monitoring: `prometheus.yml`, `alert.rules.yml`
- Скрипты: `vpn-backup.sh`, `vpn-restore.sh`
- Клиентские `.ovpn`: `vpn-client-bundles/`
- Логи: `/var/log/openvpn.log`

## Где хранится

```bash
/opt/vpn-backups/vpn-YYYY-MM-DD-HHMM/
Как создать
bash
bash scripts/vpn-backup.sh
Как восстановить
bash
bash scripts/vpn-restore.sh /opt/vpn-backups/vpn-YYYY-MM-DD-HHMM/
