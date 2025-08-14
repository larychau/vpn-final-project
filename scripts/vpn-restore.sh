#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <backup-directory>"
  exit 1
fi

BACKUP_DIR="$1"

# Проверка маркера .norestore
if [ -f "$BACKUP_DIR/.norestore" ]; then
  echo "[!] Restore blocked: .norestore marker found in $BACKUP_DIR"
  exit 1
fi

echo "[+] Restoring from backup: $BACKUP_DIR"
read -p "Confirm restore? This will overwrite existing files. [y/N]: " CONFIRM

if [[ "$CONFIRM" != "y" ]]; then
  echo "[!] Restore cancelled."
  exit 1
fi

# Восстановление client bundles
if [ -d "$BACKUP_DIR/client-bundles" ]; then
  echo "[+] Restoring client bundles..."
  rm -rf "$HOME/vpn-client-bundles"
  cp -r "$BACKUP_DIR/client-bundles" "$HOME/vpn-client-bundles"
fi

# Восстановление документации
if [ -f "$BACKUP_DIR/README.md" ]; then
  echo "[+] Restoring documentation..."
  cp "$BACKUP_DIR/README.md" "$HOME/vpn-docs/README.md"
fi

echo "[+] Restore complete."
