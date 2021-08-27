#!/bin/bash

docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "update add https://raw.githubusercontent.com/dsgrafiniert/fhem-InfluxDBLog/master/controls_influx.txt"

docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "update"

docker-compose exec fhem /usr/bin/perl /opt/fhem/fhem.pl 7072 "shutdown restart"

sleep 30

