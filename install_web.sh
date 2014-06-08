sudo apt-get update
echo "--- Installing python software properties ---"
sudo apt-get install -y vim curl python-software-properties

echo "--- Adding PHP5.5 repository ---"
sudo add-apt-repository -y ppa:ondrej/php5

echo "--- Adding NodeJS repository ---"
sudo apt-add-repository ppa:chris-lea/node.js

echo "--- Updating repository mapping ---"
sudo apt-get update

echo "--- Installing components ---"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt php5-readline php5-mysql git-core php5-xdebug nodejs

echo "--- Setting up xDebug config ---"
cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

echo "--- Enable Mod Rewrite ---"
sudo a2enmod rewrite

echo "--- Set requied PHP configs as required ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i "s/short_open_tag = .*/short_open_tag = On/" /etc/php5/apache2/php.ini
sed -i "s/disable_functions = .*/disable_functions = /" /etc/php5/cli/php.ini

echo "--- Restarting Apache to enable new config ---"
sudo service apache2 restart

echo "--- Installing Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "--- Installing gulp ---"
sudo npm install -g gulp

echo "--- All done! ---"
echo "Would you like to play a game?"