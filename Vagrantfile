# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "forwarded_port", guest: 3001, host: 3001
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.synced_folder "../genomico", "/home/vagrant/genomico"

  # config.vm.provision "shell",
  #   inline: "cp /vagrant/vagrant_files/config_files/apt.conf /etc/apt/"

  # config.vm.provision "shell",
  #   inline: "cp /vagrant/vagrant_files/config_files/.gitconfig /home/vagrant/.gitconfig"

  config.vm.provision "shell",
    inline: "apt-get update -y"

  config.vm.provision "shell",
    inline: "apt-get install python libpq-dev python-dev python-pip -y"

  config.vm.provision "shell",
    inline: "sudo pip install psycopg2"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./vagrant_files/playbook.yml"
    ansible.compatibility_mode="2.0"
  end

  config.vm.provision "shell", path: "vagrant_files/shell_scripts/install_redis.sh"

  config.vm.provision "shell", path: "vagrant_files/shell_scripts/chrome_install.sh"

end
