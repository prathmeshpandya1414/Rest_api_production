# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/focal64"  # Updated to the latest Ubuntu LTS

  config.vm.network "forwarded_port", host_ip: "127.0.0.1", guest: 8080, host: 8080

  config.vm.provision "shell", inline: <<-SHELL
    set -e  # Exit on error to stop provisioning if any command fails

    # Update and upgrade the server packages
    sudo apt-get update
    sudo apt-get -y upgrade

    # Set Ubuntu Language
    sudo locale-gen en_GB.UTF-8

    # Install Python 3, SQLite, pip, and required dependencies
    sudo apt-get install -y python3-dev sqlite3 python3-pip python3-venv

    # Upgrade pip to the latest version for Python 3
    sudo python3 -m pip install --upgrade pip

    # Install virtualenv and virtualenvwrapper
    sudo python3 -m pip install virtualenv virtualenvwrapper

    # Ensure virtualenvwrapper configuration is added to .bashrc
    if ! grep -q VIRTUALENV_ALREADY_ADDED /home/vagrant/.bashrc; then
        echo "# VIRTUALENV_ALREADY_ADDED" >> /home/vagrant/.bashrc
        echo "WORKON_HOME=~/.virtualenvs" >> /home/vagrant/.bashrc
        echo "PROJECT_HOME=/vagrant" >> /home/vagrant/.bashrc
        echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/vagrant/.bashrc
    fi

    # Source .bashrc to apply virtualenvwrapper settings
    source /home/vagrant/.bashrc

    # Try to create a virtual environment using mkvirtualenv, fallback to python3 -m venv
    if command -v mkvirtualenv &>/dev/null; then
      mkvirtualenv profiles_api --python=python3 || { echo 'Failed to create virtual environment with mkvirtualenv'; exit 1; }
    else
      python3 -m venv /home/vagrant/profiles_api || { echo 'Failed to create virtual environment with python3 -m venv'; exit 1; }
    fi

    echo 'Virtual environment created successfully!'
  SHELL

end
