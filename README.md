# Proof Of Concept for Opportunistic Security in MPLS Networks

**For detailed understanding and results of this Experiment kindly refer Report.pdf** 

Corporations and Service Providers heavily rely on MPLS to manage
their data, that means that any forms of network attacks often have the potential to disrupt
vital everyday operations. Attacks ranging from data theft to denial of service if
successful may lead to severe damages to the service provider as well as the owner of
the data.

Earlier work conducted by the Internet Engineering Task Force (IETF) have analyzed
the various vulnerabilities and security threats that affect the MPLS technology
and have drafted a potential resolution to some of the security issues. This work
proposed the implementation of Opportunistic Security in the MPLS network using
payload encryption to encrypt the underlying application data and protocols headers
using symmetric key encryption agreed upon by a key exchange between end to end or hop by hop Label Switching
Routers (LSRs) on an MPLS Label Switched Path (LSP).

This thesis describes the proof of concept for this proposed solution by implementing
it on an experimental controlled environment and measuring its effects on the
overall functionality and features of the presently running MPLS technology, the results
of which should give an idea regarding the feasibility of the solution in practical
commercial network in the world.

## Opportunistic Security
"Opportunistic Security" (OS) is defined as the use of cleartext as the baseline communication
security policy, with encryption and authentication negotiated and applied
to the communication when available. The aim of OS security is to implement
encrypted and authenticated communication between peers whenever they are capable
else only encrypted communication without authenticating the users or just clear text
communication.

OS is not intended as a substitute for authenticated, encrypted communication
when such communication is already mandated by policy (that is, by configuration
or direct request of the application) or is otherwise required to access a particular
resource. In essence, OS is employed when one might otherwise settle for cleartext.

### OS in MPLS
As proposed in https://tools.ietf.org/html/draft-ietf-mpls-opportunistic-encrypt-03#page-13 the basic requirement in MPLS OS is to provide a way to encrypt
data passing between two MPLS switches by doing a key exchange between them to
create a session key using which the encryption can be carried out. The key exchange
between the LSRs is to be carried out using the Diffie-Hellman key exchange. Using
the key values agreed after the Key exchange we encrypt the flowing packets using
Advanced Encryption Standard (AES) cryptographic algorithm. To enable authentication
of the peers as well in the encryption it is suggested to use AES in Galois/Counter
Mode (GCM).

#### Diffie-Hellman Key Exchange
Diffie-Hellman Key Exchange is a way of sharing secret information between 2 nodes
over an insecure channel. It was developed by Martin Hellman, Whitfield Diffie and
Ralph Merkle. Using this protocol the 2 nodes agree on a secret symmetric key which
can be later used in encrypting the sensitive data that is to be communicated.
The Diffie-Hellman key exchange is modelled based on the Internet Key Exchange
Protocol Version 2 as specified in the RFC 7296.

#### Advanced Encryption Standard - Galois/Counter Mode (AES-GCM)
AES is a symmetric blockcipher algorithm established by the U.S. National Institute
of Standards and Technology in 2001. It was developed by Vincent Rijmen and Joan
Daemen who won the NIST conducted AES selection process. AES is able to handle
block encryption of sizes 128, 192 and 256 bits. It is expected to provide data security
for 20-30 years and is free to use for all devices.
GCM is an Authenticated Encryption with Associated Data (AEAD) mode which
is a form of encryption that simultaneously provides data confidentiality, integrity and
authenticity. It extends AES’s encryption functionality to incorporate Authentication
and Data Integrity as well. GCM is widely adopted because of its efficiency and
parallel processing. Unlike cipher block chaining whose pipeline operations bottle neck
its efficiency, GCM makes efficient use of its instruction pipeline to provide high speed
operations using parallel processing.
The Data packet in the MPLS OS must be encrypted with AEAD-AES-GCM-128
encryption algorithm based on the specifications mentioned in the RFC 7296.

## Implementation
We will start of by first setting up the virtual network with the OVS Switches running
the traditional MPLS System. To do this we first set up the mininet virtual network
with the OpenVSwitch switches and hosts. Once the network system is in place we add the MPLS flows to the switches using OpenFlow. And finally we run a ping test to pass the ICMP packets through the MPLS switches to test the system.

### Architecture of Experiment
As Described, we will be implementing the MPLS OS system
in a virtualized environment using Mininet, OpenVSwitch and OpenFlow technology.
In order to simulate the MPLS OS structure and its effects on LSRs we need to design
a network topology where we can analyze its overall effects in all use cases. Below attached image describes the topology of the network system we will be using to demonstrate the MPLS OS system.



We will be using Mininet as our virtual network environment. The fast and clean
network topology build up and tear down speed makes Mininet a good choice for setting
up the virtual network environment. The Mininet version used in this experiment is
version 2.2.1.

We will be deploying OpenVSwitch switches in the Mininet virtual network. Mininet
has inbuilt support for setting up OpenVSwitches in its Virtual environment. The
collaboration of both Mininet and OpenVSwitch makes both their use together in a
system ideal for experimentation. The OpenVSwitch version used in this experiment
is version 2.9.2

Flow rules and actions will be passed onto the OpenVSwitches using OpenFlow
protocol. For this we need to setup an OVS controller which communicates the Open-
Flow messages to all the OVS switches in the network. The OpenVSwitch Controller
comes in built with Mininet and needs to be passed in the parameters for Mininet to
setup in the network.

As shown in the figure we will be setting up 3 switches (S1, S2, S3) in a linear
topology. Each switch has its own host (H1, H2, H3) connected to it. Switch S1 has
two interfaces s1-eth1 connected to host H1 and s1-eth2 connected to Switch S2 on
its interface s2-eth2. Switch S2 has 3 interfaces s2-eth1 connected to host S2, s2-eth2
connected to Switch S1 on its s1-eth1 interface and s2-eth3 interface connected to
Switch S3’s s3-eth2 interface. Switch s3 has 2 interfaces, s3-eth1 connected to Host
H3 and s3-eth2 connected to switch S2 on its s2-eth3 interface. Controller C0 will
communicate the MPLS flow rules to all the three switches.

The Expected behavior of the system in normal MPLS process will be as follows:
1. Host 1 will ping an ICMP packet to Host 3
2. The packet will be first forwarded to Switch S1 at its s1-eth1 interface
3. S1, based on the flow rules that we will pass via the controller, will push an
MPLS label on top of the packet and forward the packet along s1-eth2 interface.
4. Based on the linkage, S2 will receive the data packet. S2 will read the MPLS
header value and forward it along its s2-eth3 interface.
5. Based on the linkage, S3 will receive the data packet. S3 will then pop the MPLS
header and forward the normal ICMP packet to H3 via its s3-eth1 interface.
6. H3 will reply to the ICMP packet following the reverse path. the only difference
being that now S3 will push the MPLS label and S1 will pop it at the end

The Expected behavior of the system in MPLS OS process will be as follows:
1. Host 1 will ping an ICMP packet to Host 3
2. The packet will be first forwarded to Switch S1 at its s1-eth1 interface
3. S1, based on the flow rules that we passed via the controller, will first Encrypt
the payload using AES-GCM encryption algorithm the keys and IV of which,
for the scope of this project, are currently hard coded. After encryption the CW
with the low-order 16 bits of the nonce is pushed on top of the Data packet. Then
the MEL is pushed on top. A normal MPLS with value 15 is then pushed on top
of the MEL completing the MPLS OS data packet which is then forwarded onto
the s1-eth2 interface
4. Based on the linkage, S2 will receive the OS data packet. On parsing the Data
packet S2 should stop any further inspection or hash checking functions on the
underlying encrypted data. S2 should just read the MPLS header value and
forward it along its s2-eth3 interface.
5. Based on the linkage, S3 will receive the data packet. S3 will then pop the MPLS
header with the value 15. It will then read the MEL value and pop it, expecting
the next header to be the CW. S3 will the compare its low-order 16 bits of the
nonce value with the one present in the CW. If it is a match then the counters
are correct and s3 can proceed with the decryption. If not then S3 will update
its counter to continue decrypting the next oncoming packets. Once successfully
decrypted S3 will then forward the normal ICMP packet to H3 via its s3-eth1
interface.
6. H3 will reply to the ICMP packet following the reverse path with encryption on
S3 and Decryption on S1.

The Diffie-Hellman Key exchange required to initialize the Symmetric Encryption
Key and the Initialization vector for the AES-GCM encryption Algorithm is not implemented
in this experiment and as such these values are currently hard coded into
the system and can be later replaced with further development on that part. This
experiment currently only demonstrates the encryption functionality of the OS and
how the implementation of the OS Encryption affects the performance of the overall
system.

### Implementation of Opportunistic Security
The next part of the experiment involves the implementation of the OS Encryption
functionality. The four additional
functionality involved in the MPLS OS is the addition and removal of the Control Word and
the Encryption and Decryption of the MPLS Payload. These functionalities should be
performed by the OVS Switch involved in the network experiment and as such should
be implemented in the OVS code base.

After a thorough study of the OpenVSwitch codebase, it was found that there is no
such inbuilt provision in the OVS codebase for the required OS functionality. We can
neither implement the CW functionality nor the Encryption/Decryption of the MPLS
payload with the currently existing features of OVS. The functionality was thus needed
to be implemented manually into the OVS codebase and then converted into a kernel
module for the Switches to implement the same at the kernel level.

#### Changes at the Ingress (Entering) Switch
When the ICMP request packet from H1 enters S1, before pushing the MPLS header
on the data packet, S1 first encrypts the payload data using AES-GCM encryption
algorithm. The key and IV required for the encryption is currently hardcoded in the
code as their values are dependent on the Key Exchange which is not implemented in
this project. The AEAD-AES-GCM encryption is carried out using the Linux Kernel
Crypto API. After encryption the pseudo wire CW is pushed on top of the encrypted
data followed by pushing the MEL on top of it.

Due to certain implementation aspects of the Linux Kernel Crypto AEAD encryption
API, instead of encrypting the Payload data first and then adding the CW we will
first add the CW and then encrypt the underlying Payload. The details of this aspect
will be discussed further in this section.

##### Insertion of Control Word
We first create the CW data structure in the OVS codebase and assign the nonce value
to the CW sequence attribute.

In OVS datapath and Linux kernel in general, all data packets are parsed into
a fundamental data structure called a socket buffer (skb). The skb is a series of
contiguous memory location storing the data packet information in the form of bytes.
Any changes that involve manipulating the data packet have to be done by manipulating
the data bits of the skb data structure. A number of data pointers help map the
various data and header locations in the skb structure. The linux kernel has in-built
APIs to manipulate these contents. It is highly recommended to use these API’s as the
various pointer in the skb data structure are heavily interdependent on each other. Using
these APIs we manipulate the data packet and insert our CW between the payload and the MAC header of the datapacket.

##### Encryption of Data using Linux Crypto API
The Linux Kernel Crypto API is a rich set of cryptographic ciphers and data transformation
API used for cryptographic operations at the kernel level. To understand
and properly use the Crypto API functions one needs to understand their underlying
architecture specifications and the functional flow of these APIs.

The Kernel Crypto API refers to all encryption algorithms as ’transformations’.
The encryption is carried out by 2 major components, The transformation object, also
called ’Cipher Handles’ and the request handle. The transformation object contains
all the settings and configurations of the given encryption type to use. The request
handler as the name suggest handles the encryption request.

Once the payload data has been encrypted S1 can then further push the MEL label
on top of the packet followed by the Special Purpose Label Packet and another normal
MPLS packet for routing.

#### Changes at the Egress (Exiting) Switch
Once the encrypted MPLS OS packet reaches the Egress Switch S3, S3 pops the top
MPLS label along with the MEL. It then inspects nonce value in the CW header. If
the nonce counter value matches with the counter value of switch S3 then the switch
moves ahead with the decryption.

##### Decryption of Data using Linux Crypto API
Decryption of the MPLS payload follows the same procedure as the one during Encryption
process with a slight change in the input values to the API’s. During decryption, the cipher text is passed in the place of plain text into the API’s. The cipher text
is a concatenated combination of the associated data, ciphertext and authentication
tag. Also in the crypto_aead_encrypt function the flag is set to decrypt. The decryption
process authenticates the packet using the authentication tag. The process
can send out an alert if the authentication tag fails to authenticate. The output of the
decryption gives us a concatenated combination of the associated data and the plain
text.

##### Removal of CW
Just as how we used the in-built SKB manipulation APIs to insert the CW in the
Ingress Switch, we will use the same approach while removing the CW from the Data
packet.
