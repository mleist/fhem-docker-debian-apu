#!/bin/bash

cd /opt/fhem-docker-debian-apu
chown -R 472 grafana_*
docker-compose up -d
