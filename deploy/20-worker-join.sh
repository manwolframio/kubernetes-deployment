#!/bin/bash
set -e

sudo kubeadm join 172.16.0.2:6443 --token abcdef.0123456789abcdef --discovery-token-unsafe-skip-ca-verification