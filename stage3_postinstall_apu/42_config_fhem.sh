#!/bin/bash

source /opt/fhem-docker-debian-apu/.env

docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "update"
sleep 120
docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "shutdown restart"
sleep 60

docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "define influxlog InfluxDBLog infl 8086 fhem admin admin .*"
docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "attr influxlog room Wartung"
docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "save"

docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "define TCM300 TCM ESP3 ${FHEM_USB_DEV}@57600"

sleep 30
