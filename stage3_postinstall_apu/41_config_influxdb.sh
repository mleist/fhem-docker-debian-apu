#!/bin/bash
my_name=$(basename -- "$0")

source /opt/fhem-docker-debian-apu/.env

echo "starting $my_name ..."

echo "creating buckets"

docker-compose exec infl influx bucket create -n fhem_fast -o ${INFLUXDB_INIT_ORG} -r 72h
docker-compose exec infl influx bucket create -n fhem_mid -o ${INFLUXDB_INIT_ORG} -r 8w

docker-compose exec infl influx bucket list

echo "$my_name exit"
