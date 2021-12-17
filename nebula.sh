#!/bin/bash

nebula_home="$HOME/apps/nebula"
if [ -e "$nebula_home/nebula" ]; then
  echo "nebula binary exists."
else
    # download binarys
    mkdir -p $nebula_home
    cd $nebula_home
    wget https://github.com/slackhq/nebula/releases/download/v1.5.2/nebula-linux-amd64.tar.gz
    wget https://raw.githubusercontent.com/slackhq/nebula/master/examples/config.yml
    tar -xzvf nebula-linux-amd64.tar.gz
    rm nebula-linux-amd64.tar.gz
    chmod a+x *
    echo "binary and config downloaded."
fi

if [ $1 = "lighthouse" ]; then
    echo "[lighthouse] install...";
    ./nebula-cert ca -name "ybw, Inc"   # gen ca.crt & ca.key
    ./nebula-cert sign -name "lighthouse" -ip "192.168.100.1/24"
    ./nebula-cert sign -name "mac" -ip "192.168.100.2/24"
    ./nebula-cert sign -name "wsl" -ip "192.168.100.3/24"
    ./nebula-cert sign -name "tx" -ip "192.168.100.4/24"
    mv ca.key ~

    sed -i "/am_lighthouse:\ false/c\am_lighthouse:\ true" config.yml
    python3 -m http.server 61234

    mv config.yml /etc/nebula/config.yaml
    mv ca.crt /etc/nebula/ca.crt
    mv lighthouse.crt /etc/nebula/host.crt
    mv lighthouse.key /etc/nebula/host.key

elif [ $1 = "node" ]; then
    echo "[node] install...";
    node_name=$2; server_host=$3
    sudo mkdir -p /etc/nebula
    sudo wget "$server_host:61234/$node_name.key" -O /etc/nebula/host.key
    sudo wget "$server_host:61234/$node_name.crt" -O /etc/nebula/host.crt
    sudo wget "$server_host:61234/ca.crt"         -O /etc/nebula/ca.crt
    sed -i "s/100.64.22.11/$server_host/g" config.yml
    sudo mv config.yml /etc/nebula/config.yaml
fi

