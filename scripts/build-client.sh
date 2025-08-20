#!/bin/bash

set -e

PKI="$HOME/vpn-client"
OUT="$PKI/client-igor.ovpn"

CA="$PKI/ca.crt"
CERT="$PKI/client-igor.crt"
KEY="$PKI/client-igor.key"

# Проверка наличия
for f in "$CA" "$CERT" "$KEY"; do
  [ -f "$f" ] || { echo "❌ Missing file: $f"; exit 1; }
done

# Сборка .ovpn
cat > "$OUT" <<CONFIG
client
dev tun
proto udp
remote 34.68.126.247 1194
nobind
persist-key
persist-tun

remote-cert-tls server
verify-x509-name server name

cipher AES-256-CBC
auth SHA256
data-ciphers AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305:AES-256-CBC
data-ciphers-fallback AES-256-CBC

tls-version-min 1.2
tls-client
verb 3

<ca>
$(cat "$CA")
</ca>

<cert>
$(cat "$CERT")
</cert>

<key>
$(cat "$KEY")
</key>
CONFIG

chmod 600 "$OUT"
echo "Saved: $OUT"
