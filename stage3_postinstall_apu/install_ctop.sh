#!/bin/bash

echo 'deb http://packages.azlux.fr/debian/ buster main' | tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | apt-key add -
apt update
apt install docker-ctop
