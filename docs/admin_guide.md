cat <<EOF > admin_guide.md
# Руководство администратора

## Настройка CA

\`\`\`bash
sudo ./scripts/ca-init.sh
\`\`\`

## Настройка VPN

\`\`\`bash
sudo ./scripts/vpn-setup.sh
\`\`\`

## Генерация клиента

\`\`\`bash
sudo ./scripts/client-gen.sh username
\`\`\`

## Мониторинг

- Prometheus: \`http://vpn-server:9090\`
- Exporter: \`http://vpn-server:9176/metrics\`

## Бэкап

\`\`\`bash
sudo ./scripts/backup.sh
\`\`\`
EOF
