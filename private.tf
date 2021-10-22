# creating Elastic IP for NAt
resource "aws_eip" "nat_eip_1" {
  vpc = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "Nat EIP 1"
  }
}

resource "aws_eip" "nat_eip_2" {
  vpc = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "Nat EIP 2"
  }
}

# create private subnet
resource "aws_subnet" "private_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "private_1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "private_2"
  }
}

# Create Nat Gateway 1 in Public Subnet 1
# Create Nat Gateway 2 in Public Subnet 2
resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.nat_eip_1.id
  subnet_id = aws_subnet.public_1.id

  tags = {
    Name = "nat 1 gateway"
  }
}

resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.nat_eip_2.id
  subnet_id = aws_subnet.public_2.id

  tags = {
    Name = "nat 2 gateway"
  }
}

# Create Private Route Table 1 and Add Route Through Nat Gateway 1
# Create Private Route Table 2 and Add Route Through Nat Gateway 2
resource "aws_route_table" "private_rt_1" {
  vpc_id = aws_vpc.vpc.id

  route  {
    cidr_block = var.cidr
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }

  tags = {
    Name = "private_rt_1"
  }
}

resource "aws_route_table" "private_rt_2" {
  vpc_id = aws_vpc.vpc.id

  route  {
    cidr_block = var.cidr
    nat_gateway_id = aws_nat_gateway.nat_2.id
  }

  tags = {
    Name = "private_rt_2"
  }
}

#creating association between private subnet and private route table
resource "aws_route_table_association" "private_1" {
  subnet_id = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_rt_2.id
}