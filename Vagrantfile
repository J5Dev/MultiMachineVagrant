# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.define "db" do |db|
    db.vm.network :private_network, ip: "192.168.10.21"
    db.vm.hostname = "localdev-db"
    db.vm.provision :shell, :path => "install_db.sh"
  end

  config.vm.define "web" do |web|
    web.vm.network :private_network, ip: "192.168.10.22"
    web.vm.hostname = "localdev-web"
    web.vm.provision :shell, :path => "install_web.sh"
    web.vm.synced_folder "websites", "/var/www", :owner => 'www-data', :group => 'www-data'
    web.vm.synced_folder "sites-available", "/etc/apache2/sites-available", :owner => 'root', :group => 'root'
  end
end