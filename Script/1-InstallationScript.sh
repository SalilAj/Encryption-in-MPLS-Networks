#!/bin/bash
# Bash Script to install mininet, OpenVSwitch controller and Wireshark
# Author Salil Ajgaonkar - Trinity College Dublin

# To install mininet
sudo apt install mininet

# To install OVS controller separately as it is not packaged with mininet
sudo apt install openvswitch-testcontroller
sudo cp /usr/bin/ovs-testcontroller /usr/bin/ovs-controller

# To install Wireshark to monitor network traffic
sudo apt install wireshark



