#!/bin/bash
set -e

KEY_PATH="$HOME/.ssh/id_ed25519"
REMOTE_URL=$(git remote get-url origin)

echo "[+] Checking SSH key at: $KEY_PATH"

# Проверка наличия ключа
if [ ! -f "$KEY_PATH" ]; then
  echo "[!] SSH private key not found: $KEY_PATH"
  exit 1
fi

if [ ! -f "$KEY_PATH.pub" ]; then
  echo "[!] SSH public key not found: $KEY_PATH.pub"
  exit 1
fi

echo "[+] SSH key pair exists."

# Проверка remote URL
echo "[+] Checking Git remote URL..."
echo "    Current origin: $REMOTE_URL"

if [[ "$REMOTE_URL" != git@github.com:* ]]; then
  echo "[!] Remote origin is not using SSH. Run:"
  echo "    git remote set-url origin git@github.com:<user>/<repo>.git"
  exit 1
fi

echo "[+] Remote origin is using SSH."

# Проверка подключения к GitHub
echo "[+] Testing GitHub SSH access..."
ssh -T git@github.com || {
  echo "[!] SSH authentication to GitHub failed."
  exit 1
}

echo "[+] SSH access to GitHub is working."
