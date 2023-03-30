echo "apt update"
sudo apt-get update

echo "instalando network-manager"
sudo apt-get -y install network-manager

echo "estado del servicio"
resolvectl status

sudo bash -c 'echo DNS=1.1.1.1 1.0.0.1 >> /etc/systemd/resolved.conf'
sudo bash -c 'echo FallbackDNS=8.8.8.8 8.8.4.4 >> /etc/systemd/resolved.conf'
sudo bash -c 'echo Domains=~. >> /etc/systemd/resolved.conf'
sudo bash -c 'echo DNSSEC=yes >> /etc/systemd/resolved.conf'
sudo bash -c 'echo DNSOverTLS=yes >> /etc/systemd/resolved.conf'

echo "reniciando servicio"
sudo systemctl restart systemd-resolved
sudo systemctl restart NetworkManager
resolvectl status

echo "borrando cache"
sudo resolvectl flush-caches

echo "haciendo un query a google"
resolvectl query google.com