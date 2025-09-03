#!/bin/bash
set -e
trap 'echo "[!] Ошибка на строке $LINENO"; exit 1' ERR

if [ -z "$1" ]; then
  echo "Usage: $0 <backup-directory>"
  exit 1
fi

BACKUP_DIR="$1"
logger "[vpn-restore] Restore initiated from $BACKUP_DIR"

# Проверка маркера .norestore
if [ -f "$BACKUP_DIR/.norestore" ]; then
  echo "[!] Restore blocked: .norestore marker found in $BACKUP_DIR"
  logger "[vpn-restore] Restore aborted due to .norestore marker"
  exit 1
fi

echo "[+] Restoring from backup: $BACKUP_DIR"

# Восстановление client bundles
if [ -d "$BACKUP_DIR/client-bundles" ]; then
  echo "[+] Restoring client bundles..."
  rm -rf "$HOME/vpn-client-bundles"
  cp -r "$BACKUP_DIR/client-bundles" "$HOME/vpn-client-bundles"
  logger "[vpn-restore] Client bundles restored"
else
  echo "[!] No client bundles found in backup"
  logger "[vpn-restore] Client bundles missing in backup"
fi

# Восстановление OpenVPN лога
if [ -f "$BACKUP_DIR/openvpn.log" ]; then
  echo "[+] Restoring OpenVPN log..."
  sudo cp "$BACKUP_DIR/openvpn.log" /var/log/openvpn.log
  logger "[vpn-restore] OpenVPN log restored"
  if [ ! -f /var/log/openvpn.log ]; then
    echo "[!] Failed to restore OpenVPN log"
    exit 1
  fi
else
  echo "[!] No OpenVPN log found in backup"
  logger "[vpn-restore] OpenVPN log missing in backup"
fi

# Восстановление документации
if [ -f "$BACKUP_DIR/README.md" ]; then
  echo "[+] Restoring documentation..."
  cp "$BACKUP_DIR/README.md" "$HOME/vpn-docs/README.md"
  logger "[vpn-restore] Documentation restored"
fi

echo "[+] Restore complete."
logger "[vpn-restore] Restore completed successfully"
