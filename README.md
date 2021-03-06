MultiMachineVagrant
===================

Starter Kit for multi-machine Vagrant environment, designed for use with Multiple projects, with a persistant db server environment.

This will setup and create a MySQL server (5.6), and an Apache web server running php5.5, and complete with composer, git & xdebug.

Both servers will also have [Webmin](http://www.webmin.com/) installed for simpler management moving forward if you aren't a fan of using the command line.

The web server also comes with an upstart script for apache, so the web server will be restarted AFTER vagrant has mounted the drives. This ensures no issues with site configs not being loaded at the time of the server startup.

##Requirements##

Before starting, you will need to install the following:

####Oracle's Virtualbox####

Used to manage virtual machine, and a simple pojnt & click installation.

[Install & Setup Virtualbox](https://www.virtualbox.org/wiki/Downloads)

####Vagrant####
Obviously needed to run a vagrant machine!

[Install & Setup Vagrant](http://www.vagrantup.com/downloads.html)

##Setup Instructions##

Start by cloning the repo, or by downloading the zip file and unarchiving it to the desired location. This can be set anywhere, and be called anything you like.

After you are happy with the servers location, open up the vagrantfile, and set the desired config options for both the DB & WEB server, then save the file.

Once completed, open your prefered command line tool, and cd to the package folder. once there, simply type the following:

    vagrant up

This will then start to create the virtual servers environments, and install the various components. This may take a while so go get a drink while it completes. Once finished you're ready to go!

##Usage##

###Starting the servers up###

After the servers are first initialised, they will be already running, so will not need starting. However for future times, simply navigate to the vagrant environment on your command line, and type the following:

    vagrant up

###Accessing the servers###

Accessing the servers is simple, and can be done so by simply navigating to the vagrant environment on the command line, and typing the following:

#####Web Server#####
    vagrant ssh web

#####MySQL Server#####

    vagrant ssh db

Once on the servers they will operate, and can be used exactly as you would a normal server, so you can change, configure and install anything you need to have your environment exactoy as you need it.

###Stopping/Halting the servers###

Once finished with the servers, in order to retain any changes you have made to the setup or configuration, or to retain any changes to the databases, simply stop the servers as opposed to destroying them. This can be done by navigating to your vagrant environment on the command line, and typing the following:

    vagrant halt

###Adding a new site to the server###

#####Adding the web files#####
Within the package, a websites folder is already in place. This folder is already mapped to the "/var/www/html" directory, ao any site should be added to this folder. One is already in place as a demonstration. Use the DemoSite as a template or simply rename it and use this one.

Anything placed in, or changed within this folder is also being done within the "/var/www/html" folder of the web server due to symlynks, so no need to duplicate things!

#####Setting the Apache config#####
Again, a demo config is provided which is already set to run with the provided DemoSite files. This includes the config, and provides the link which you can use to access the site in yout browser (using Xip). If you do not wish to access your sites that way, (if your using some other local DNS solution), simply change as required.

Once you have added or changed the demo config, you simply need to enable it within apache, as the folder is synced to the server. You can do this by following the below instructions:

Navigate to the vagrant environment on the command line, and type the following:

    vagrant ssh web

Once on the server you need to enable the site config, by typing the following:

    sudo a2ensite YourSiteConfigName.conf

Then restart or reload apache, by using on of the following:

    sudo service apache2 reload

or

    sudo service apache2 restart

Once done, your site will be ready to access in your browser.


##Special Thanks##

This has been put together using inspiration from a number of sources, as well as making use of some fantastic tools put together by others. I would like to express my thanks to:

* Jeffrey Way - @jeffrey_way / @laracasts - [Laracasts](http://laracasts.com)
* Chris Fidao - @fideloper - [Fideloper](http://fideloper.com)
