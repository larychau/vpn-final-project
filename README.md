# vpn-final-project
## Проверка подключения клиента OpenVPN (client-igor)

### Контекст

- Хост (client): `dev-vm`
- Конфиг: `/etc/openvpn/igor.conf`
- Интерфейс: `tun2`
- IP клиента: `10.8.0.4`
- Сервер: `another-vm`, IP `10.128.0.4`
- Статус-файл сервера: `/run/openvpn/server.status`

---

### Шаги проверки

1. **Интерфейс**

   ```bash
   ip a show dev tun2
Ожидаем: inet 10.8.0.4/24 scope global tun2

Маршрут

bash
ip route
Ожидаем: 10.8.0.0/24 dev tun2 proto kernel scope link src 10.8.0.4

Пинг до сервера

bash
ping -c 3 10.8.0.1
Ожидаем: 64 bytes from 10.8.0.1: icmp_seq=1 ttl=64 time=...

Внешний IP

bash
curl -s ifconfig.me
Ожидаем: внешний IP сервера, если redirect-gateway активен

Статус на сервере

bash
sudo cat /run/openvpn/server.status | grep 10.8.0.4
Ожидаем:

Код
CLIENT_LIST,client-igor,...
ROUTING_TABLE,10.8.0.4,...
IP Forwarding

bash
sudo sysctl net.ipv4.ip_forward
Ожидаем: net.ipv4.ip_forward = 1

iptables

bash
sudo iptables -L -v -n | grep DROP
Если ICMP блокируется — разрешить:

bash
sudo iptables -A INPUT -i tun+ -p icmp -j ACCEPT
sudo iptables -A OUTPUT -o tun+ -p icmp -j ACCEPT
Результат
Если все шаги пройдены — клиент client-igor подключён, туннель активен, маршрут работает, ICMP доступен, сервер видит клиента.
