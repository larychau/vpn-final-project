# CA Setup (another-vm)

## Installation

```bash
sudo dpkg -i debs/openvpn-ca_1.0-1_all.deb
sudo setup-ca.sh
mages@another-vm:~$ sudo openssl x509 -in /etc/openvpn/easy-rsa/pki/ca.crt -noout -subject -dates
subject=CN = another-vm-CA
notBefore=Aug 20 10:07:58 2025 GMT
notAfter=Aug 18 10:07:58 2035 GMT
