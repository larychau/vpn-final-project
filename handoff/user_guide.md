markdown
# Руководство пользователя VPN

## Как подключиться

1. Получите файл `client-igor.ovpn` из `vpn-client-bundles/`
2. Скопируйте его на клиентскую машину
3. Установите OpenVPN:

```bash
sudo apt install openvpn
Подключитесь:

bash
sudo openvpn --config client-igor.ovpn
Проверьте IP:

bash
curl ifconfig.me
Как получить .ovpn
На CA-сервере:

bash
sudo bash scripts/build-client.sh igor
Файл появится в vpn-client-bundles/
