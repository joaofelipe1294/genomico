#!/bin/bash

# install Chrome
sudo su <<HERE
  # ls /root
  echo 'https_proxy = http://proxy.cdapp.net.br:3128/' >> /etc/wgetrc
  echo 'http_proxy = http://proxy.cdapp.net.br:3128/' >> /etc/wgetrc
  echo 'ftp_proxy = http://proxy.cdapp.net.br:3128/' >> /etc/wgetrc
HERE
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install -y google-chrome-stable
