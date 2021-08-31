#!/bin/bash

#echo 'deb http://packages.azlux.fr/debian/ bullseye main' | tee /etc/apt/sources.list.d/azlux.list
#wget -qO - https://azlux.fr/repo.gpg.key | apt-key add -
#apt update
#apt install docker-ctop

wget https://github.com/bcicen/ctop/releases/download/0.7.6/ctop-0.7.6-linux-amd64 -O /usr/local/bin/ctop
chmod +x /usr/local/bin/ctop
