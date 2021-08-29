#!/bin/bash

source /opt/fhem-docker-debian-apu/.env
set -x

docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "define allowedWEB allowed"
docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "attr allowedWEB validFor WEB"
docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "attr allowedWEB basicAuth { \"\$user:\$password\" eq \"${FHEM_USER}:${FHEM_PASSWORD}\" }"


docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "update"
sleep 120
docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "shutdown restart"
sleep 60

#docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "define influxlog InfluxDBLog infl 8086 fhem admin admin .*"
#docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "attr influxlog room Wartung"

docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "define TCM300 TCM ESP3 ${FHEM_USB_DEV}@57600"
docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "save"

sleep 30
