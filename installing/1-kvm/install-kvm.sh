#!/bin/bash

# Instalacion
sudo apt-get update
sudo apt install -y build-essential
sudo apt-get -y install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd

# Verificacion
sudo systemctl status libvirtd

# Añadimos los usuarios
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER

if lscpu | grep -q GenuineIntel; then
  echo "options kvm-intel nested=1" | sudo tee /etc/modprobe.d/kvm.conf
elif lscpu | grep -q AuthenticAMD; then
  echo "options kvm-amd nested=1" | sudo tee /etc/modprobe.d/kvm.conf
fi

