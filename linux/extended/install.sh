#!/bin/bash

##
## This script installs Prometheus (2.1.1), Grafana and ElasticSearch.
## Must be executed as root user.
## Copyright (c) 2021 Fabrick (https://fabrick.io)
## Do not use this script for production.
## Version 1.0.0
##

RELEASE="2.2.1"

systemctl is-active --quiet prometheus
if [ $? -eq 0 ]
then
    echo "Prometheus already running. Skip Prometheus installation"
else
    echo "Step 1/3 - Installing Prometheus $RELEASE"

    echo "Step 1/3 - Downloads and untar Prometheus"
    wget https://github.com/prometheus/prometheus/releases/download/v${RELEASE}/prometheus-${RELEASE}.linux-amd64.tar.gz

    tar xvf prometheus-${RELEASE}.linux-amd64.tar.gz
    cd prometheus-${RELEASE}.linux-amd64/

    echo "Step 1/3 - Creates user and roles"
    groupadd --system prometheus
    useradd -s /sbin/nologin -r -g prometheus prometheus

    echo "Step 1/3 - Creates folders and configuration files"
    mkdir -p /etc/prometheus/{rules,rules.d,files_sd}  /var/lib/prometheus
    cp prometheus promtool /usr/local/bin/
    cp -r consoles/ console_libraries/ /etc/prometheus/
    touch /etc/prometheus/prometheus.yml
    chown -R prometheus:prometheus /etc/prometheus/  /var/lib/prometheus/
    chmod -R 775 /etc/prometheus/ /var/lib/prometheus/

    echo "Step 1/3 - Setting up service"
    curl "https://raw.githubusercontent.com/fabrick/kapsul/main/linux/extended/configs/prometheus.service" -o /etc/systemd/system/prometheus.service


    echo "Step 1/3 - Starting Prometheus service"
    systemctl start prometheus
    systemctl enable prometheus

    rm -rf prometheus-${RELEASE}.linux-amd64
    rm prometheus-${RELEASE}.linux-amd64.tar.gz
    echo "Step 1/3 - Prometheus successfully installed!"
fi

echo "Step 2/3 - Installing Grafana"

systemctl is-active --quiet grafana-server
if [ $? -eq 0 ]
then
    echo "Grafana already running. Skip Grafana installation"
else
    apt-get install -y apt-transport-https
    apt-get install -y software-properties-common wget
    wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
    echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
    apt-get update
    apt-get install grafana
    systemctl daemon-reload
    systemctl start grafana-server
    systemctl enable grafana-server
    echo "Step 2/3 - Grafana successfully installed !"
fi

echo "Step 3/3 - Installing ElasticSearch"

systemctl is-active --quiet elasticsearch
if [ $? -eq 0 ]
then
    echo "ElasticSearch already running. Skip ES installation"
else
    apt-get install -y apt-transport-https
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
    apt-get update
    apt-get install elasticsearch
    systemctl daemon-reload
    systemctl start elasticsearch
    systemctl enable elasticsearch
    echo "Step 3/3 - ES successfully installed !"
fi
