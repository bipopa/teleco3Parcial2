echo "rpm install"
yum install -y rpm


echo "dnfUpdate"
dnf update -y

echo "installing vim and net-tools"
yum install -y vim net-tools wget

echo "Installing Apache"
yum install -y httpd httpd-tools

echo "Adding Apache service to autostart"
chkconfig httpd on

echo "Starting Apache"
service httpd restart


echo "installing dns(bind)"
yum install -y bind-utils bind-libs bind-*

echo "Adding bind service to autostart"
chkconfig named on

echo "Starting bind"
service named restart

echo "Installing FTP"
yum install -y vsftpd
chkconfig vsftpd on

