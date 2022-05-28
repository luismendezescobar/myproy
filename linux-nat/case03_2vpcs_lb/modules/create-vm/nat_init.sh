sudo sysctl -w net.ipv4.ip_forward=1
#iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo yum install httpd -yum
echo "Example web page to pass health check" | tee /var/www/html/index.html
sudo systemctl enable --now httpd
