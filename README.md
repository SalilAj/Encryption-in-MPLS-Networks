# Encryption-in-MPLS-Networks
This is an ongoing research for my Dissertation involving implementation of Encryption in the MPLS networks

Configurations used:
Ubuntu 16.04.3 LTS run on a Virtual Machine with host Machine being Windows 8.1

Steps to create virtual Switches using mininet and Openflow Communication protocol:

Step 1: Install mininet (Run the below Command)
sudo apt install mininet

Step 2: Run the following command to implement 3 switches within the mininet virtual network
sudo mn --topo single,3 --controller remote --switch ovsk,protocol=OpenFlow13
