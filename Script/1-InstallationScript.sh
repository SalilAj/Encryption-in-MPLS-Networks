#!/bin/bash
# Bash Script to install mininet, OpenVSwitch controller and Wireshark
# Author Salil Ajgaonkar - Trinity College Dublin

# To install mininet
sudo apt install mininet

# To install OVS controller separately as it is not packaged with mininet*
sudo apt install openvswitch-testcontroller
sudo cp /usr/bin/ovs-testcontroller /usr/bin/ovs-controller

# To install Wireshark to monitor network traffic
sudo apt install wireshark

#Issue:
#*Mininet removed the ovs-controller from its default installation from version 2.1 onwards and also renamed it to ovs-testcontroller. You need to separately install ovs-testcontroller and replace it with the ovs-controller directory in the bin folder.
