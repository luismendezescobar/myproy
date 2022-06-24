#!/bin/bash
# Enable IP forwarding:
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/20-iptables.conf

#this one is needed for centos 7 otherwise won't work
echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf

#yum install iptables-services -y
#sudo systemctl enable --now iptables


#sudo iptables -F     
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

#sudo yum install tcpdump -y



#iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# Read VM network configuration:
#md_vm="http://169.254.169.254/computeMetadata/v1/instance/"
#md_net="$md_vm/network-interfaces"
#nic0_gw="$(curl $md_net/0/gateway -H "Metadata-Flavor:Google" )"
#nic0_mask="$(curl $md_net/0/subnetmask -H "Metadata-Flavor:Google")"
#nic0_addr="$(curl $md_net/0/ip -H "Metadata-Flavor:Google")"
#nic0_id="$(ip addr show | grep $nic0_addr | awk '{print $NF}')"
#nic1_gw="$(curl $md_net/1/gateway -H "Metadata-Flavor:Google")"
#nic1_mask="$(curl $md_net/1/subnetmask -H "Metadata-Flavor:Google")"
#nic1_addr="$(curl $md_net/1/ip -H "Metadata-Flavor:Google")"
#nic1_id="$(ip addr show | grep $nic1_addr | awk '{print $NF}')"
# Source based policy routing for nic1
#echo "100 rt-nic1" >> /etc/iproute2/rt_tables
#sudo ip rule add pri 32000 from $nic1_gw/$nic1_mask table rt-nic1
#sleep 1
#sudo ip route add 35.191.0.0/16 via $nic1_gw dev $nic1_id table rt-nic1
#sudo ip route add 130.211.0.0/22 via $nic1_gw dev $nic1_id table rt-nic1
#sudo ip route add 172.16.1.0/24 via $nic1_gw dev $nic1_id table rt-nic1
#sudo ip route add 192.168.1.0/24 via $nic1_gw dev $nic1_id table rt-nic1

