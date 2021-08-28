#!/bin/bash

source /opt/fhem-docker-debian-apu/.env

#docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "update add https://raw.githubusercontent.com/dsgrafiniert/fhem-InfluxDBLog/master/controls_influx.txt"
#docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "update"
#docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "shutdown restart"

docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "define influxlog InfluxDBLog infl 8086 fhem admin admin .*"
docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "attr influxlog room Wartung"
docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "save"

docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "define TCM300 TCM ESP3 ${FHEM_USB_DEV}@57600"

# define TCM300 TCM ESP3 /dev/serial/by-id/usb-EnOcean_GmbH_EnOcean_USB_300_DB_FT1ZIG8I-if00-port0@57600



sleep 30
