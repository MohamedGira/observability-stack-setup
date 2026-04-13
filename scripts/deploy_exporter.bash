#!/bin/bash
set -xe

script_dir=$(dirname "$0")
#ensure docker and docker-compose are installed
$script_dir/checks.sh


exporters_dir=`realpath "$script_dir/../exporters"`
cat $script_dir/compose_template.service | \
sed "s|WORKDIR|$exporters_dir|g ; s|SERVICE_DESCRIPTION|Prometheus Exporter Service|g" | \
sudo tee /etc/systemd/system/exporter.service

sudo systemctl daemon-reload
sudo systemctl enable exporter.service
sudo systemctl start exporter.service