#!/bin/bash
set -xe
script_dir=$(dirname "$0")
#ensure docker and docker-compose are installed
$script_dir/checks.sh

prometheus_dir=`realpath "$script_dir/.."`
cat $script_dir/compose_template.service | \
sed "s|WORKDIR|$prometheus_dir|g ; s|SERVICE_DESCRIPTION|Prometheus Stack Service (prometheus,grafana, alertmanager) |g" | \
sudo tee /etc/systemd/system/prometheus.service

sudo systemctl daemon-reload
sudo systemctl enable prometheus.service
sudo systemctl start prometheus.service