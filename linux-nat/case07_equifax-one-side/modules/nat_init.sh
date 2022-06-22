#!/bin/bash
# Enable IP forwarding:
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/20-iptables.conf

#this one is needed for centos 7 otherwise won't work
echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf


sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
sudo iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
sudo iptables -A FORWARD -p tcp --dport 443 -j ACCEPT
sudo iptables -A FORWARD -p udp --dport 53 -j ACCEPT
sudo iptables -A FORWARD -p icmp -j DROP
sudo iptables -A FORWARD -p tcp --dport 1:65535 -j DROP

#iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# Read VM network configuration:
md_vm="http://169.254.169.254/computeMetadata/v1/instance/"
md_net="$md_vm/network-interfaces"
nic0_gw="$(curl $md_net/0/gateway -H "Metadata-Flavor:Google" )"
nic0_mask="$(curl $md_net/0/subnetmask -H "Metadata-Flavor:Google")"
nic0_addr="$(curl $md_net/0/ip -H "Metadata-Flavor:Google")"
nic0_id="$(ip addr show | grep $nic0_addr | awk '{print $NF}')"
nic1_gw="$(curl $md_net/1/gateway -H "Metadata-Flavor:Google")"
nic1_mask="$(curl $md_net/1/subnetmask -H "Metadata-Flavor:Google")"
nic1_addr="$(curl $md_net/1/ip -H "Metadata-Flavor:Google")"
nic1_id="$(ip addr show | grep $nic1_addr | awk '{print $NF}')"
# Source based policy routing for nic1
echo "100 rt-nic1" >> /etc/iproute2/rt_tables
sudo ip rule add pri 32000 from $nic1_gw/$nic1_mask table rt-nic1
sleep 1
sudo ip route add 35.191.0.0/16 via $nic1_gw dev $nic1_id table rt-nic1
sudo ip route add 130.211.0.0/22 via $nic1_gw dev $nic1_id table rt-nic1
# Use a web server to pass the health check for this example.
#sudo yum install httpd -y
#sudo echo "Example web page to pass health check" | tee /var/www/html/index.html
#sudo systemctl enable --now httpd
#this configuration works fine
