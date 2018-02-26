# Encryption-in-MPLS-Networks
This is an ongoing research for my Dissertation involving implementation of Encryption in the MPLS networks

Configurations used:
Ubuntu 16.04.3 LTS run on a Virtual Machine with host Machine being Windows 8.1

Steps to create virtual Switches using mininet and Openflow Communication protocol:

Step 1: Install mininet (Run the below Command)

sudo apt install mininet

Step 2: Run the following command to implement 3 switches within the mininet virtual network

sudo mn --topo single,3 --controller remote --switch ovsk,protocol=OpenFlow13

Step 2.1 (Optional/Recommended) Change the switches from Unix Sockets to TCP Ports. Execute the below mentioned commands while the swithches are running on the mininet.

S1=tcp:127.0.0.1:6634
S2=tcp:127.0.0.1:6635
S3=tcp:127.0.0.1:6636

Step 2.2 (Optional/Recommended) It is important to reconstruct the mapping between port numbers.This mapping is sometimes different from the expected one (e.g., port 2 may correspond to interface s1-eth3) and may change for each run of openvswitch.

 eval $(sudo ovs-ofctl dump-ports-desc s1 |sed -n '/^ [0-9]/s/^ *//p' |awk -v FS='\\(|\\)' '{print toupper($2) "=" $1}' |sed 's/-/_/')
 eval $(sudo ovs-ofctl dump-ports-desc s2 |sed -n '/^ [0-9]/s/^ *//p' |awk -v FS='\\(|\\)' '{print toupper($2) "=" $1}' |sed 's/-/_/')
 eval $(sudo ovs-ofctl dump-ports-desc s3 |sed -n '/^ [0-9]/s/^ *//p' |awk -v FS='\\(|\\)' '{print toupper($2) "=" $1}' |sed 's/-/_/')
 
 Step 3: Implement the Rules to the switches (* currently facing an issue of assigning the in_port values, port values are out of range)
 
Rule at S1:

sudo ovs-ofctl -O OpenFlow13 add-flow $S1 "table=0,in_port=$S1_ETH1,eth_type=0x800,actions=goto_table:1"
sudo ovs-ofctl -O OpenFlow13 add-flow $S1 "table=0,in_port=$S1_ETH2,eth_type=0x8847,actions=goto_table:1"

Rule at S2:

sudo ovs-ofctl -O OpenFlow13 add-flow $S1 "table=1,in_port=$S1_ETH1,eth_type=0x800,actions=push_mpls:0x8847,set_field:12->mpls_label,output:$S1_ETH2"
sudo ovs-ofctl -O OpenFlow13 add-flow $S1 "table=1,in_port=$S1_ETH2,eth_type=0x8847,mpls_bos=0,actions=pop_mpls:0x8847,resubmit(,1)"
sudo ovs-ofctl -O OpenFlow13 add-flow $S1 "table=1,in_port=$S1_ETH2,eth_type=0x8847,mpls_bos=1,actions=pop_mpls:0x800,output:$S1_ETH1"

Rule at S3:

sudo ovs-ofctl -O OpenFlow13 add-flow $S3 "table=0,in_port=$S3_ETH1,eth_type=0x800,actions=goto_table:1"
sudo ovs-ofctl -O OpenFlow13 add-flow $S3 "table=0,in_port=$S3_ETH2,eth_type=0x8847,actions=goto_table:1"

sudo ovs-ofctl -O OpenFlow13 add-flow $S3 "table=1,in_port=$S3_ETH1,eth_type=0x800,actions=push_mpls:0x8847,set_field:32->mpls_label,output:$S3_ETH2"
sudo ovs-ofctl -O OpenFlow13 add-flow $S3 "table=1,in_port=$S3_ETH2,eth_type=0x8847,mpls_bos=0,actions=pop_mpls:0x8847,resubmit(,1)"
sudo ovs-ofctl -O OpenFlow13 add-flow $S3 "table=1,in_port=$S3_ETH2,eth_type=0x8847,mpls_bos=1,actions=pop_mpls:0x800,output:$S3_ETH1"


Step X: Test the connection between the switches by calling 'pingall' in the mininet terminal

(Will only work for default mininet switches, the switches wont be able to ping if they are of the type ovsk with a remote controller. You are required to input the rules into the switches for them to be able to ping (*Currently working on this))

Reference:
http://tocai.dia.uniroma3.it/compunet-wiki/index.php/MPLS_with_OpenFlow:_howto#Setup_of_OpenFlow_rules_.28Open_vSwitch.29

https://github.com/mininet/openflow-tutorial/wiki/docs.openvswitch.org/en/latest/tutorials/
