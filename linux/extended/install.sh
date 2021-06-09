#!/bin/bash

##
## This script installs Prometheus (2.1.1) and Grafana .
## Must be executed as root user.
## Copyright (c) 2021 Fabrick (https://fabrick.io)
##
## Version 1.0.0
##

RELEASE="2.2.1"

echo "Step 1/2 - Installing Prometheus $RELEASE"

echo "Step 1/2 - Downloads and untar Prometheus"
wget https://github.com/prometheus/prometheus/releases/download/v${RELEASE}/prometheus-${RELEASE}.linux-amd64.tar.gz

tar xvf prometheus-${RELEASE}.linux-amd64.tar.gz
cd prometheus-${RELEASE}.linux-amd64/

echo "Step 1/2 - Creates user and roles"
groupadd --system prometheus
useradd -s /sbin/nologin -r -g prometheus prometheus

echo "Step 1/2 - Creates folders and configuration files"
mkdir -p /etc/prometheus/{rules,rules.d,files_sd}  /var/lib/prometheus
cp prometheus promtool /usr/local/bin/
cp -r consoles/ console_libraries/ /etc/prometheus/
touch /etc/prometheus/prometheus.yml
chown -R prometheus:prometheus /etc/prometheus/  /var/lib/prometheus/
chmod -R 775 /etc/prometheus/ /var/lib/prometheus/

echo "Step 1/2 - Setting up service"
curl "https://raw.githubusercontent.com/fabrick/kapsul/main/linux/extended/configs/prometheus.service" -o /etc/systemd/system/prometheus.service


echo "Step 1/2 - Starting Prometheus service"
systemctl start prometheus
systemctl enable prometheus

