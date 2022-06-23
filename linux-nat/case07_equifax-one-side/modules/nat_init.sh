#!/bin/bash
# Enable IP forwarding:
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/20-iptables.conf

#this one is needed for centos 7 otherwise won't work
echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf
yum install iptables-services -y
sudo systemctl enable --now iptables


sudo iptables -F     #for testing
sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
#sudo iptables -A FORWARD -p icmp -j DROP
#sudo iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
#sudo iptables -A FORWARD -p tcp --dport 443 -j ACCEPT
#sudo iptables -A FORWARD -p udp --dport 53 -j ACCEPT
#sudo iptables -A FORWARD -p tcp --dport 1:1024 -j DROP
#if we add ports above 1024 is going to act up

#the correct configuraton would be, remove the iptables -F then add the below rules
#sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
#sudo iptables -I FORWARD -p tcp --dport 80 -m state --state NEW -j ACCEPT
#sudo iptables -I FORWARD -p tcp --dport 443 -m state --state NEW -j ACCEPT
#sudo iptables -I FORWARD -p tcp -m state --state related,ESTABLISH -j ACCEPT



sudo yum install tcpdump -y

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

#this one is for the instance to respond on the secondary nic
#sudo ifconfig eth1 10.10.10.4 netmask 255.255.255.0 broadcast 10.10.10.4 mtu 1430
echo "1 rt1" | sudo tee -a /etc/iproute2/rt_tables
sudo ip route add $nic1_gw src $nic1_addr dev $nic1_id table rt1
sudo ip route add default via $nic1_gw dev $nic1_id table rt1
sudo ip rule add from $nic1_addr/$nic1_mask table rt1
sudo ip rule add to $nic1_addr/$nic1_mask  table rt1