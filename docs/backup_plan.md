cat <<EOF > backup_plan.md
# План резервного копирования

## Что бэкапим

- PKI: \`ca.crt\`, \`ca.key\`, \`issued/\`, \`private/\`
- Кон## 📄 Шаг 8. Заполни `monitoring_design.md`

```bash
cat <<EOF > monitoring_design.md
# Проектирование мониторинга

## Что мониторим

- OpenVPN
- CPU, RAM, диск

## Используемые компоненты

- Prometheus
- OpenVPN Exporter
- Node Exporter
- Alertmanager

## Алерты

- VPN down
- Нет подключений
- CPU > 90%
- RAM > 90%
EOF
