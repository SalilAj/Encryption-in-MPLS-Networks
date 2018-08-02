#remove the existing openvswitch kernel module if already present and then install the new module
sudo rmmod openvswitch
sudo make install
sudo make modules_install
sudo modprobe openvswitch
#EXIT
