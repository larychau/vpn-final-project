#!/bin/bash
set -e

BUNDLE_DIR="$HOME/vpn-client-bundles"
CONFIG_FILE="$BUNDLE_DIR/client.ovpn"

echo "[+] Validating VPN client bundle at: $BUNDLE_DIR"

# Проверка .ovpn
if [ ! -f "$CONFIG_FILE" ]; then
  echo "[!] Missing client.ovpn"
  exit 1
fi

# Проверка ключей и сертификатов
REQUIRED_FILES=("client.key" "client.crt" "ca.crt")

for FILE in "${REQUIRED_FILES[@]}"; do
  if ! grep -q "$FILE" "$CONFIG_FILE"; then
    echo "[!] $FILE not referenced in client.ovpn"
  fi
  if [ ! -f "$BUNDLE_DIR/$FILE" ]; then
    echo "[!] Missing file: $FILE"
    exit 1
  fi
done

# Проверка формата .ovpn
if ! grep -q "remote " "$CONFIG_FILE"; then
  echo "[!] Missing 'remote' directive in client.ovpn"
  exit 1
fi

if ! grep -q "proto " "$CONFIG_FILE"; then
  echo "[!] Missing 'proto' directive in client.ovpn"
  exit 1
fi

echo "[+] All required files and directives are present."

# Вывод команды для запуска
echo "[>] To test manually:"
echo "    sudo openvpn --config \"$CONFIG_FILE\""

