resource "aws_instance" "private-servers" {
  count                     = var.environment == "Production" ? 6 : 3
  ami                       = lookup(var.amis, var.aws_region)
  instance_type             = var.instance_type
  subnet_id                 = element(var.private_subnet_cidr, count.index)
  key_name                  = var.key_name
  vpc_security_group_ids    = [var.sg_id]

  tags = {
    Name        = "${var.vpc_name}-private-server"
    environment = var.environment
  }

user_data = file("${path.module}/private_server_user_data.sh")


# user_data  = <<-EOF
#      #!/bin/bash
#      sudo apt update
#      sudo apt install nginx -y
#      sudo apt install git -y
#      sudo git clone https://github.com/RajPractiseRepo/Sidecar_Test.git
#      sudo rm -rf /var/www/html/index.nginx-debian.html
#      sudo cp  Sidecar_Test/index.html /var/www/html/index.html
#      echo "<h1>${var.vpc_name}-private-Server-${count.index + 1}</h1>" >> /var/www/html/index.html
#      sudo systemctl start nginx
#      sudo systemctl enable nginx
#  EOF
depends_on = [var.elb_listener]

} 


