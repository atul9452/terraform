#!/bin/bash
export http_proxy=your_ip_address
export https_proxy=your_ip_address
echo $http_proxy
sleep 1s
sudo -E yum -y update
sleep 1s
sudo -E yum -y install wget
sleep 1s
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sleep 1s
sudo -E rpm -ivh mysql-community-release-el7-5.noarch.rpm
sleep 1s
sudo -E yum -y update
sleep 1s
sudo -E yum -y install mysql-server
sleep 1s
sudo systemctl start mysqld
sleep 1s
mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='username';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db !='test' OR Db !='test_%';
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'username'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
EOF
