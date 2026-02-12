#!/bin/bash

sudo apt-get -y install nfs-kernel-server
sudo systemctl enable --now nfs-server
sudo apt-get -y build-dep vagrant ruby-libvirt
sudo apt-get -y install ebtables dnsmasq-base
sudo apt-get -y install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev