# Encryption-in-MPLS-Networks
This is an ongoing research for my Dissertation involving implementation of Encryption in the MPLS networks

Configurations used:
Ubuntu 16.04.3 LTS run on a Virtual Machine with host Machine being Windows 8.1

Steps to create virtual Switches using mininet and Openflow Communication protocol:

Step 1: Install mininet (Run the below Command)

sudo apt install mininet

Step 2: Run the following command to implement 3 switches within the mininet virtual network

sudo mn --topo single,3 --controller remote --switch ovsk,protocol=OpenFlow13

Step 3: Test the connection between the switches by calling 'pingall' in the mininet terminal
(Will only work for default mininet switches, the switches wont be able to ping if they are of the type ovsk with a remote controller. You are required to input the rules into the switches for them to be able to ping (*Currently working on this))

Reference:
http://tocai.dia.uniroma3.it/compunet-wiki/index.php/MPLS_with_OpenFlow:_howto#Setup_of_OpenFlow_rules_.28Open_vSwitch.29

https://github.com/mininet/openflow-tutorial/wiki

docs.openvswitch.org/en/latest/tutorials/
