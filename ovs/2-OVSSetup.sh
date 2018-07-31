#!/bin/bash
clear
sudo ./configure --with-linux=/lib/modules/$(uname -r)/build --enable-sparse --enable-Werror # sparse and Werror are optional

#remove the existing openvswitch kernel module if already present 
sudo rmmod openvswitch

# compile and install the new openvswitch kernel module 
sudo make
sudo make install
sudo make modules_install
sudo modprobe openvswitch
#END

