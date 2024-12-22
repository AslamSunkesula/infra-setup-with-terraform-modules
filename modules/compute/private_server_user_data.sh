#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo apt install git -y
sudo git clone https://github.com/RajPractiseRepo/Sidecar_Test.git
sudo rm -rf /var/www/html/index.nginx-debian.html
sudo cp Sidecar_Test/index.html /var/www/html/index.html
echo "<h1>${var.vpc_name}-private-Server-${count.index + 1}</h1>" >> /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
