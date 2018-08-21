#!/bin/bash
clear
echo -e "\n---------------Removing OVS Module--------------\n"
sudo rmmod openvswitch

echo -e "\n---------------Stopping OVS Daemons--------------\n"
sudo /usr/local/share/openvswitch/scripts/ovs-ctl stop

echo -e "\n---------------Building OVS CodeBase--------------\n"
sudo make -C ovs
retvalue=$?
if [ $retvalue != '0' ]
then
	echo -e "\nBuild FAILED\n"
	exit
fi

echo -e "\n---------------Installing Build--------------\n"
sudo make install -C ovs
retvalue=$?
if [ $retvalue != '0' ]
then
	echo -e "\nBuild Installation FAILED\n"
	exit
fi

echo -e "\n---------------Installing Kernel Module--------------\n"
sudo make modules_install -C ovs
retvalue=$?
if [ $retvalue != '0' ]
then
	echo -e "\n---------------Kernel Installation Failed--------------\n"
	exit
fi

echo -e "\n---------------Loading OpenvSwitch Module--------------\n"
sudo modprobe openvswitch
retvalue=$?
if [ $retvalue != '0' ]
then
	echo -e "\n---------------OpenvSwitch Module Loading FAILED--------------\n"
	exit
fi

echo -e "\n---------------Starting OVS Daemons--------------\n"
sudo /usr/local/share/openvswitch/scripts/ovs-ctl start
retvalue=$?
if [ $retvalue != '0' ]
then
	echo -e "\n---------------OVS Daemons FAILED to Start--------------\n"
	exit
fi

