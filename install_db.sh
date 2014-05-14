sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get install -y vim curl python-software-properties
sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update

sudo apt-get install -y mysql-server mysqltuner

sed -i 's/bind-address.*/bind-address = 0.0.0.0/g' /etc/mysql/my.cnf
service mysql restart

echo "--- All done! Would you like to play a game? ---"