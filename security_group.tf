# creating security group for website
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.vpc.id
  name = "web_security_group"

  ingress   {
    cidr_blocks = [var.cidr]
    from_port = 80
    to_port = 80
    protocol = "tcp"
    # self = false
    description = "HTTP"
    security_groups = [ aws_security_group.bastion_sg.id ]
  } 

  egress {
    cidr_blocks = [var.cidr]
    from_port = 0
    to_port = 0
    protocol = "-1"
    # self = false
    security_groups = [ aws_security_group.bastion_sg.id ]
  }

    tags = {
        name = "vpc_web_security_group"
    }
}

# creating security group for data base
resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.vpc.id
  name = "db_security_group"

  ingress   {
    cidr_blocks = [var.cidr]
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
  } 

  egress {
    cidr_blocks = [var.cidr]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

    tags = {
        name = "vpc_db_security_group"
    }
}

# creating security group for bastion
resource "aws_security_group" "bastion_sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "dev-bastion-host"
  description = "Enable SSH access to the bastion host from external via SSH port"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr]
  }

  tags = {
    Name        = "dev-bastion-sg"
    Environment = "dev"
  }
}


resource "aws_security_group" "ssh_sg" {
  vpc_id      = aws_vpc.vpc.id
  description = "Enable SSH access to the Private instances from the bastion via SSH port"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# creating security group for application load balancer
resource "aws_security_group" "alb_sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "alb"
  description = "allow inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr]
  }

  tags = {
    Name        = "allow_ports"
  }
}