#!/bin/bash
set -euo pipefail

log() { logger "[setup-ca] $1"; echo "[setup-ca] $1"; }

if ! command -v easy-rsa &>/dev/null; then
  log "easy-rsa не найден"; exit 1
fi

cd /etc/openvpn/easy-rsa || { log "Папка easy-rsa не найдена"; exit 1; }

log "Инициализация PKI"
./easyrsa init-pki || { log "Ошибка при init-pki"; exit 1; }

log "Создание CA"
./easyrsa build-ca nopass || { log "Ошибка при build-ca"; exit 1; }

log "Генерация запроса сервера"
./easyrsa gen-req server nopass || { log "Ошибка при gen-req"; exit 1; }

log "Подпись запроса сервера"
./easyrsa sign-req server server || { log "Ошибка при sign-req"; exit 1; }

log "CA успешно создана"
