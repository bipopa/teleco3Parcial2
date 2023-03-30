echo "upgrading rpm"
yum install -y rpm

echo "Installing Apache"
yum install -y httpd httpd-tools

echo "Adding Apache service to autostart"
chkconfig httpd on

echo "Starting Apache"
service httpd restart

echo "Installing dns"
yum install -y bind-utils bind-libs bind-*


echo "Adding DNS service to autostart"
chkconfig named on

echo "Starting dns"
service named restart

echo "Installing FTP"
yum install -y vsftpd

chkconfig vsftpd on

echo "Starting ftp"
service vsftpd restart


echo "configuring firewall"

sudo firewall-cmd --zone=internal --change-interface=eth0
sudo firewall-cmd --zone=internal --change-interface=eth2
sudo firewall-cmd --zone=dmz --change-interface=eth1

sudo firewall-cmd --set-default-zone=dmz

sudo firewall-cmd --zone=dmz --add-service=http 
sudo firewall-cmd --zone=dmz --add-service=https
sudo firewall-cmd --zone=dmz --add-service=dns 
sudo firewall-cmd --zone=dmz --add-service=ftp

sudo firewall-cmd --zone=internal --add-service=http 
sudo firewall-cmd --zone=internal --add-service=https
sudo firewall-cmd --zone=internal --add-service=dns 
sudo firewall-cmd --zone=internal --add-service=ftp

sudo firewall-cmd --zone=internal --add-masquerade
sudo firewall-cmd --zone=dmz --add-masquerade

firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o eth1 -j MASQUERADE 
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth2 -o eth1 -j ACCEPT 
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth1 -o eth2 -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo firewall-cmd --permanent --zone=dmz --add-forward-port=port=20-22:proto=tcp:toport=20-22:toaddr=192.168.50.8
sudo firewall-cmd --permanent --zone=dmz --add-forward-port=port=30000-31000:proto=tcp:toport=30000-31000:toaddr=192.168.50.8
sudo firewall-cmd --permanent --zone=dmz --add-port=20-22/tcp
sudo firewall-cmd --permanent --zone=dmz --add-port=30000-31000/tcp

sudo firewall-cmd --permanent --zone=internal --add-port=20-22/tcp
sudo firewall-cmd --permanent --zone=internal --add-port=30000-31000/tcp
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --reload
