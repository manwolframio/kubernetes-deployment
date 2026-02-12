#!/bin/bash
set -e

sudo kubeadm init --apiserver-advertise-address=172.16.0.2 --pod-network-cidr=10.244.0.0/16 --token abcdef.0123456789abcdef --token-ttl 0
mkdir -p "$HOME/.kube"
sudo cp -i /etc/kubernetes/admin.conf "$HOME/.kube/config"
sudo chown "$(id -u)":"$(id -g)" "$HOME/.kube/config"

kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
