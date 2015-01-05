# -*- mode: ruby -*-
# vi: set ft=ruby :

# DB Server Config
db_ip = "192.168.10.21"
db_hostname = "localdev-db.local"
db_cpu_cores = "2"
db_memory = "2048"

# Web Server Config
web_ip = "192.168.10.22"
web_hostname = "localdev-web.local"
web_cpu_cores = "2"
web_memory = "2048"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.define "db" do |db|
    db.vm.network :private_network, ip: db_ip
    db.vm.hostname = db_hostname

    db.vm.provider :virtualbox do |vb|
      vb.name = db_hostname
      # Set server cpus
      vb.customize ["modifyvm", :id, "--cpus", db_cpu_cores]
      # Set server memory
      vb.customize ["modifyvm", :id, "--memory", db_memory]
    end

    db.vm.provision :shell, :path => "install_db.sh"
  end

  config.vm.define "web" do |web|
    web.vm.network "forwarded_port", guest: 80, host: 8080 #HTTP
    web.vm.network "forwarded_port", guest: 443, host: 4443 #HTTPS
    web.vm.network :private_network, ip: web_ip
    web.vm.hostname = web_hostname

    web.vm.provider :virtualbox do |vb|
      vb.name = web_hostname
      # Set server cpus
      vb.customize ["modifyvm", :id, "--cpus", web_cpu_cores]
      # Set server memory
      vb.customize ["modifyvm", :id, "--memory", web_memory]
    end


    web.vm.provision :shell, :path => "install_web.sh"
    web.vm.synced_folder "websites", "/var/www/html", :owner => 'www-data', :group => 'www-data'
    web.vm.synced_folder "sites-available", "/etc/apache2/sites-available", :owner => 'root', :group => 'root'
  end
end