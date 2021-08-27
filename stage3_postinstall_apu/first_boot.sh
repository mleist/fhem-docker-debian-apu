#!/bin/bash

FLAG="/var/log/firstboot.log"
if [ ! -f $FLAG ]; then
   #Put here your initialization sentences
   echo "This is the first boot"

   cd /opt
   ssh-keyscan -H github.com >> /root/.ssh/known_hosts
   git clone git@github.com:mleist/fhem-docker-debian-apu.git

   /opt/fhem-docker-debian-apu/stage3_postinstall_apu/install_ctop.sh

   #the next line creates an empty file so it won't run the next boot
   touch $FLAG
else
   echo "Do nothing"
fi
