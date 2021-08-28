#!/bin/bash

source /opt/fhem-docker-debian-apu/.env

docker-compose exec infl influx bucket create -n fhem_fast -o ${INFLUXDB_INIT_ORG} -r 72h
docker-compose exec infl influx bucket create -n fhem_mid -o ${INFLUXDB_INIT_ORG} -r 8w
