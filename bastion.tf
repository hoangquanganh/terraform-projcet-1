
resource "aws_instance" "bastion" {
  ami                         = "ami-0d058fe428540cd89"
  instance_type               = "t2.micro"
  key_name                    = "bastion key"
  vpc_security_group_ids      = ["${aws_security_group.bastion_sg.id}"]
  subnet_id                   = aws_subnet.public_1.id
  associate_public_ip_address = true
  monitoring                  = true

  tags = {
    Name        = "dev-bastion"
    Environment = "dev"
  }

# ssh conection
# first Connect to the bastion host form local use
# "ssh ec2-user@<bastion-IP-address or DNS-entry> -i .\bastion key.pem"
# in bastion, copy the key to get access to ec2
# use "cd /home/ec2-user
#      vim ec2-key.pem
#      chmod 400 ec2-key.pem"
# finaly Connect to ec2 from the bastion host use
# "ssh ec2-user@<instance-IP-address or DNS-entry -i .\ec2-key.pem>"

root_block_device {
  encrypted = true
  }
}