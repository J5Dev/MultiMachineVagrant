#!/usr/bin/env bash

sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get install -y vim curl python-software-properties
sudo add-apt-repository -y ppa:ondrej/mysql-5.6
sudo apt-get update

sudo apt-get install -y apt-show-versions mysql-server-5.6 mysqltuner perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl

sed -i 's/bind-address.*/bind-address = 0.0.0.0/g' /etc/mysql/my.cnf

mysql -uroot -proot -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root'";
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'";
mysql -uroot -proot -e "FLUSH PRIVILEGES";

service mysql restart

echo "--- Installing Webmin ---"
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.730_all.deb
sudo dpkg -i webmin_1.730_all.deb
sudo apt-get install -f

echo "--- All done! Would you like to play a game? ---"