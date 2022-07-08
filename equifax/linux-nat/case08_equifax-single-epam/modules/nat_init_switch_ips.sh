#!/bin/bash
# Enable IP forwarding:
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/20-iptables.conf
#this one is needed for centos 7 otherwise won't work
echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf

#Enable iptable service
#yum install iptables-services -y
#sudo systemctl enable --now iptables
#for testing we will leave these 2, but after testing is completed we are going to use the below configuration
#sudo iptables -F

#we enable this line if we use centos
#sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

#for ubuntu is like this one
sudo sysctl net.ipv4.conf.all.forwarding=1
sudo iptables --table nat --append POSTROUTING --out-interface ens5 -j MASQUERADE


#the correct configuraton would be, remove the iptables -F then add the below rules
#sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
#sudo iptables -I FORWARD -p tcp --dport 80 -m state --state NEW -j ACCEPT
#sudo iptables -I FORWARD -p tcp --dport 443 -m state --state NEW -j ACCEPT
#sudo iptables -I FORWARD -p tcp -m state --state related,ESTABLISH -j ACCEPT


# Source based policy routing for nic1
# this will allow the nic1 to reply back when it gets request from 
#the google ranges 35.191.0.0/16 && 130.211.0.0/22
#also from the vdi range 10.137.32.0/20 that way we can login 
#to the nat-linux from any vdi server, this is because the primary eth0
#is connected to the isolated network which doesn't allow you to ssh into it
#that's why the secondary eth1 needs to be used to ssh into if need it for something
sleep 100
md_vm="http://169.254.169.254/computeMetadata/v1/instance/"
md_net="$md_vm/network-interfaces"
nic1_gw="$(curl $md_net/1/gateway -H "Metadata-Flavor:Google")"
nic1_mask="$(curl $md_net/1/subnetmask -H "Metadata-Flavor:Google")"
nic1_addr="$(curl $md_net/1/ip -H "Metadata-Flavor:Google")"
nic1_id="$(ip addr show | grep $nic1_addr | awk '{print $NF}')"
# Source based policy routing for nic1
sudo echo "100 rt-nic1" >> /etc/iproute2/rt_tables
sudo ip rule add pri 32000 from $nic1_gw/$nic1_mask table rt-nic1
sleep 1
sudo ip route add 35.191.0.0/16 via $nic1_gw dev $nic1_id table rt-nic1
sudo ip route add 130.211.0.0/22 via $nic1_gw dev $nic1_id table rt-nic1
sudo ip route add 10.137.32.0/20 via $nic1_gw dev $nic1_id table rt-nic1
sudo ip route add 140.82.0.0/16 via $nic1_gw dev $nic1_id table rt-nic1
sudo ip route add 8.8.8.8/32 via $nic1_gw dev $nic1_id table rt-nic1

##doing some testing from here to below
#this route is to go to git hub
