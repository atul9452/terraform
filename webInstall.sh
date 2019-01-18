#!/bin/bash
export http_proxy=your_proxy
export https_proxy=your_proxy
echo $http_proxy
sudo -E yum -y update
sleep 1s
sudo -E yum -y install httpd
sudo service httpd start
sudo -E yum -y update
sudo -E yum -y install wget
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo -E rpm -ivh mysql-community-release-el7-5.noarch.rpm
sudo -E yum -y update
sudo -E yum -y install mysql-server
sudo systemctl start mysqld
sudo -E yum -y install php php-mysql
sudo chkconfig httpd on
sudo chkconfig mysqld on
cd /var/www/html
sudo -E git clone "https://github.com/atul9452/phpapp.git"
cd /var/www/html/phpapp/pdo
sql_s=${floatip}
sudo sed -i "s/unique_name/$sql_s/g" /var/www/html/phpapp/pdo/config.php
cd /var/www/html/phpapp/pdo
/usr/bin/php install.php
sleep 1s
sudo sed -i 's/DirectoryIndex index.html/DirectoryIndex index.html index.php/g' /etc/httpd/conf/httpd.conf/httpd
sudo systemctl restart httpd