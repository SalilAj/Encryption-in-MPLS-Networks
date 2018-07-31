#!/bin/bash
# Bash Script to add Open Flow Rules to the MPLS switches set up in mininet
# Author Salil Ajgaonkar - Trinity College Dublin

#sudo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,Open_vSwitch,manager_options --private-key=db:Open_vSwitch,SSL,private_key --certificate=db:Open_vSwitch,SSL,certificate --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert --pidfile --detach
#sudo ovs-vsctl --no-wait init
#sudo ovs-vswitchd --pidfile --detach

#Start the openvswitch daemons (ovsdb daemon and vswitchd daemon)
sudo export PATH=$PATH:/usr/local/share/openvswitch/scripts
sudo ovs-ctl start

#Command to start the mininet virtual network with the ovs switches
sudo mn --topo linear,3 --switch ovsk
#END

