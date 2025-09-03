#!/bin/bash
set -e
trap 'echo "[!] Ошибка на строке $LINENO"; exit 1' ERR

logger "[vpn-validate] Starting post-deploy validation"

echo "[+] Проверка VPN-интерфейса (tun0)"
ip a | grep tun0 && logger "[vpn-validate] tun0 interface is up" || {
  echo "[!] Интерфейс tun0 не найден"
  logger "[vpn-validate] tun0 interface missing"
  exit 1
}

echo "[+] Проверка внешнего IP"
EXTERNAL_IP=$(curl -s ifconfig.me || echo "unreachable")
echo "External IP: $EXTERNAL_IP"
logger "[vpn-validate] External IP: $EXTERNAL_IP"

echo "[+] Проверка node_exporter"
curl -s localhost:9100/metrics | grep node_cpu_seconds_total && logger "[vpn-validate] node_exporter OK" || {
  echo "[!] node_exporter не отвечает"
  logger "[vpn-validate] node_exporter failed"
  exit 1
}

echo "[+] Проверка openvpn_exporter"
curl -s localhost:9176/metrics | grep openvpn_server_connected_clients && logger "[vpn-validate] openvpn_exporter OK" || {
  echo "[!] openvpn_exporter не отвечает"
  logger "[vpn-validate] openvpn_exporter failed"
  exit 1
}

echo "[+] Проверка Prometheus алертов"
curl -s localhost:9090/api/v1/alerts | grep '"state":"firing"' && logger "[vpn-validate] Prometheus alerts firing" || {
  echo "[!] Нет активных алертов или Prometheus недоступен"
  logger "[vpn-validate] Prometheus alerts not firing"
}

echo "[+] Проверка конфигурации Prometheus"
[ -f /etc/prometheus/prometheus.yml ] && logger "[vpn-validate] prometheus.yml found" || {
  echo "[!] prometheus.yml не найден"
  logger "[vpn-validate] prometheus.yml missing"
  exit 1
}

echo "[+] Проверка завершена успешно"
logger "[vpn-validate] Post-deploy validation completed"
