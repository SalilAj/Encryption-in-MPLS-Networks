#!/bin/bash
# Bash Script to add Open Flow Rules to the MPLS switches set up in mininet and run wireshark for network monitoring
# Author Salil Ajgaonkar - Trinity College Dublin

#Rules for Switch s1
sudo ovs-ofctl -O OpenFlow13 add-flow s1 "table=0,in_port=1,eth_type=0x800,actions=goto_table:1"
sudo ovs-ofctl -O OpenFlow13 add-flow s1 "table=0,in_port=2,eth_type=0x8847,actions=goto_table:1"
sudo ovs-ofctl -O OpenFlow13 add-flow s1 "table=1,in_port=1,eth_type=0x800,actions=push_mpls:0x8847,set_field:12->mpls_label,output:2"
sudo ovs-ofctl -O OpenFlow13 add-flow s1 "table=1,in_port=2,eth_type=0x8847,mpls_bos=0,actions=pop_mpls:0x8847,resubmit(,1)"
sudo ovs-ofctl -O OpenFlow13 add-flow s1 "table=1,in_port=2,eth_type=0x8847,mpls_bos=1,actions=pop_mpls:0x800,output:1"

#Rules for Switch s2
sudo ovs-ofctl -O OpenFlow13 add-flow s2 "table=0,in_port=2,eth_type=0x8847,actions=push_mpls:0x8847,set_field:23->mpls_label,push_mpls:0x8847,set_field:100->mpls_label,output:3"
sudo ovs-ofctl -O OpenFlow13 add-flow s2 "table=0,in_port=3,eth_type=0x8847,actions=push_mpls:0x8847,set_field:21->mpls_label,push_mpls:0x8847,set_field:200->mpls_label,output:2"

#Rules for Switch s3
sudo ovs-ofctl -O OpenFlow13 add-flow s3 "table=0,in_port=1,eth_type=0x800,actions=goto_table:1"
sudo ovs-ofctl -O OpenFlow13 add-flow s3 "table=0,in_port=2,eth_type=0x8847,actions=goto_table:1"
sudo ovs-ofctl -O OpenFlow13 add-flow s3 "table=1,in_port=1,eth_type=0x800,actions=push_mpls:0x8847,set_field:32->mpls_label,output:2"
sudo ovs-ofctl -O OpenFlow13 add-flow s3 "table=1,in_port=2,eth_type=0x8847,mpls_bos=0,actions=pop_mpls:0x8847,resubmit(,1)"
sudo ovs-ofctl -O OpenFlow13 add-flow s3 "table=1,in_port=2,eth_type=0x8847,mpls_bos=1,actions=pop_mpls:0x800,output:1"

#Rules for ARP
sudo ovs-ofctl -O OpenFlow13 add-flow s1 "table=0,in_port=1,eth_type=0x806,actions=output:2"
sudo ovs-ofctl -O OpenFlow13 add-flow s1 "table=0,in_port=2,eth_type=0x806,actions=output:1"
sudo ovs-ofctl -O OpenFlow13 add-flow s2 "table=0,in_port=2,eth_type=0x806,actions=output:3"
sudo ovs-ofctl -O OpenFlow13 add-flow s2 "table=0,in_port=3,eth_type=0x806,actions=output:2"
sudo ovs-ofctl -O OpenFlow13 add-flow s3 "table=0,in_port=1,eth_type=0x806,actions=output:2"
sudo ovs-ofctl -O OpenFlow13 add-flow s3 "table=0,in_port=2,eth_type=0x806,actions=output:1"

# Run WireShark
sudo wireshark
