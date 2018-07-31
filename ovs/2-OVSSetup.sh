#!/bin/bash
clear
./configure --with-linux=/lib/modules/$(uname -r)/build --enable-sparse --enable-Werror # sparse and Werror are optional

#remove the existing openvswitch kernel module if already present 
#sudo rmmod openvswitch

# I did a make clean first
# I manuall removed a link to actions.c from datapath/linux which was in the repo

# compile and install the new openvswitch kernel module 
make
# do these manually or make dependant on a good build
#sudo make install
#sudo make modules_install
#sudo modprobe openvswitch
#END

