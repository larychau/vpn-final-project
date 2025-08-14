#!/bin/bash
set -e

DATE=$(date +%F-%H%M)
BACKUP_ROOT="$HOME/vpn-backups"
BACKUP_DIR="$BACKUP_ROOT/vpn-$DATE"

echo "[+] Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Marker to prevent accidental restore
touch "$BACKUP_DIR/.norestore"

# Backup client bundles
if [ -d "$HOME/vpn-client-bundles" ]; then
  echo "[+] Backing up client bundles..."
  cp -r "$HOME/vpn-client-bundles" "$BACKUP_DIR/client-bundles"
else
  echo "[!] No client bundles found at ~/vpn-client-bundles"
fi

# Backup OpenVPN log
if [ -f /var/log/openvpn.log ]; then
  echo "[+] Backing up OpenVPN log..."
  sudo cp /var/log/openvpn.log "$BACKUP_DIR/openvpn.log"
else
  echo "[!] No OpenVPN log found at /var/log/openvpn.log"
fi

# Backup documentation
if [ -f "$HOME/vpn-docs/README.md" ]; then
  echo "[+] Backing up VPN documentation..."
  cp "$HOME/vpn-docs/README.md" "$BACKUP_DIR/README.md"
fi

echo "[+] Backup complete: $BACKUP_DIR"
