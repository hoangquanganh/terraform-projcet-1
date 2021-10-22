# creating EC2 
resource "aws_instance" "ec2" {
  ami = "ami-0d058fe428540cd89"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.web_sg.id}" ]
  subnet_id = aws_subnet.private_1.id
  key_name = "bastion key"
  associate_public_ip_address = true

  tags = {
    name = "ec2 in private subnet"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y mysql-client
    sudo apt update
    sudo apt install nginx
    sudo ufw allow 'Nginx HTTP'
    sudo apt install mysql-server
    sudo mysql_secure_installation
    sudo apt install php-fpm php-mysql
    sudo apt install httpd -y
  EOF
}

# create ssh key pem
resource "tls_private_key" "public_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion_key" {
  key_name    = "bastion_key"
  public_key  = tls_private_key.public_key.public_key_openssh
}