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

