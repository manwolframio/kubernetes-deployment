#!/bin/bash
echo "Si el comando devuelve >1 el PC es apto para virtualizar"
egrep -c vmx /proc/cpuinfo
