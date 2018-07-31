# Encryption-in-MPLS-Networks
This is an ongoing research for my Dissertation involving implementation of Encryption in the MPLS networks

Configurations used:
Ubuntu 16.04.3 LTS run on a Virtual Machine with host Machine being Windows 8.1

Steps to create virtual Switches using mininet and Openflow Communication protocol:

Run Script: 1-InstallationScript.sh
This Scripts installs all the basic technologies needed to run the virtualized network and the MPLS switches.

Run Script: 2-NetworkSetupScript.sh
This Script runs the virtualized network 'mininet' and starts a basic linear topology of 3 Open Flow Switches connected to eachother

Run Script: 3-AddFlowScript.sh
This Script adds the flow instructions to the switches

Step X: Test the flow of packets between the MPLS switches by calling 'h1 ping h2' in the mininet terminal

Monitoring: Monitor the flow of packets flowing through the switches using wireshark

Issue 1:
Will only work for default mininet switches, the switches wont be able to ping if they are of the type ovsk with a remote controller. You are required to input the rules into the switches for them to be able to ping..
Resolution: Mininet removed the ovs-controller from its default installation from version 2.1 onwards and also renamed it to ovs-testcontroller. You need to separately install ovs-testcontroller and replace it with the ovs-controller directory in the bin folder.

Reference:
http://tocai.dia.uniroma3.it/compunet-wiki/index.php/MPLS_with_OpenFlow:_howto#Setup_of_OpenFlow_rules_.28Open_vSwitch.29

https://github.com/mininet/openflow-tutorial/wiki/docs.openvswitch.org/en/latest/tutorials/
