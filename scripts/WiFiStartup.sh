#!/bin/bash

sudo ip link set dev wlp1s0 up
sudo wpa_supplicant -B -i wlp1s0 -c /etc/wpa_supplicant/wpa_supplicant-wlp1s0.conf
sudo dhcpcd wlp1s0
