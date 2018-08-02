#!/bin/bash
clear
./configure --with-linux=/lib/modules/$(uname -r)/build --enable-sparse --enable-Werror # sparse and Werror are optional

#remove the existing openvswitch kernel module if already present 
#sudo rmmod openvswitch

# I did a make clean first
# I manuall removed a link to actions.c from datapath/linux which was in the repo

# build the new openvswitch code
make clean
make
#END

