#!/bin/bash
set -e
trap 'echo "[!] Ошибка на строке $LINENO"; exit 1' ERR

DATE=$(date +%F-%H%M)
BACKUP_ROOT="/opt/vpn-backups"
BACKUP_DIR="$BACKUP_ROOT/vpn-$DATE"

echo "[+] Creating backup directory: $BACKUP_DIR"
sudo mkdir -p "$BACKUP_DIR"
sudo chmod 700 "$BACKUP_DIR"
logger "[vpn-backup] Backup started at $BACKUP_DIR"

# Marker to prevent accidental restore
touch "$BACKUP_DIR/.norestore"

# Backup client bundles
if [ -d "$HOME/vpn-client-bundles" ]; then
  echo "[+] Backing up client bundles..."
  cp -r "$HOME/vpn-client-bundles" "$BACKUP_DIR/client-bundles"
  logger "[vpn-backup] Client bundles backed up"
else
  echo "[!] No client bundles found at ~/vpn-client-bundles"
fi

# Backup OpenVPN log
if [ -f /var/log/openvpn.log ]; then
  echo "[+] Backing up OpenVPN log..."
  sudo cp /var/log/openvpn.log "$BACKUP_DIR/openvpn.log"
  logger "[vpn-backup] OpenVPN log backed up"
  if [ ! -f "$BACKUP_DIR/openvpn.log" ]; then
    echo "[!] Failed to copy OpenVPN log"
    exit 1
  fi
else
  echo "[!] No OpenVPN log found at /var/log/openvpn.log"
fi

# Backup documentation (optional)
if [ -f "$HOME/vpn-docs/README.md" ]; then
  echo "[+] Backing up VPN documentation..."
  cp "$HOME/vpn-docs/README.md" "$BACKUP_DIR/README.md"
  logger "[vpn-backup] Documentation backed up"
fi

echo "[+] Backup complete: $BACKUP_DIR"
