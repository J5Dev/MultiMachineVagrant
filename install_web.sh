#!/usr/bin/env bash

sudo apt-get update
echo "--- Installing python software properties ---"
sudo apt-get install -y vim curl python-software-properties build-essential

echo "--- Adding PHP5.5 repository ---"
sudo add-apt-repository -y ppa:ondrej/php5

echo "--- Adding NodeJS repository ---"
sudo apt-add-repository ppa:chris-lea/node.js

echo "--- Updating repository mapping ---"
sudo apt-get update

echo "--- Installing components ---"
sudo apt-get install -y php5 apache2 sqlite libapache2-mod-php5 php5-cli php5-curl php5-gd php5-mcrypt php5-readline php5-sqlite php5-mysql php5-mssql php5-pgsql php5-curl php5-gd php5-gmp php5-mcrypt php5-memcached php5-imagick php5-xdebug git-core nodejs perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python

echo "--- Setting up xDebug config ---"
cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.scream=0
xdebug.cli_color=1
xdebug.show_local_vars=1

; var_dump display
xdebug.var_display_max_depth = 5
xdebug.var_display_max_children = 256
xdebug.var_display_max_data = 1024
EOF

echo "--- Enable Mod Rewrite ---"
sudo a2enmod rewrite

echo "--- Set requied PHP configs as required ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i "s/short_open_tag = .*/short_open_tag = On/" /etc/php5/apache2/php.ini
sed -i "s/disable_functions = .*/disable_functions = /" /etc/php5/cli/php.ini
sed -i "s/;date.timezone = .*/date.timezone = UTC/" /etc/php5/apache2/php.ini
sed -i "s/;date.timezone = .*/date.timezone = UTC/" /etc/php5/cli/php.ini

echo "--- Restarting Apache to enable new config ---"
sudo service apache2 restart

echo "--- Creating Upstart Script for apache ---"
cat << EOF | sudo tee -a /etc/init/httpd.conf # start apache on vagrant mounted

start on vagrant-mounted

exec sudo service apache2 restart
EOF

echo "--- Installing Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "--- Installing Webmin ---"
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.730_all.deb
sudo dpkg -i webmin_1.730_all.deb
sudo apt-get install -f

echo "--- All done! Would you like to play a game? ---"