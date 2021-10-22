resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch  = true
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "public_1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch  = true
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "public_2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
      cidr_block = var.cidr
      gateway_id = aws_internet_gateway.igw.id
  }
  
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public-1-a" {
  subnet_id = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public-2-b" {
  subnet_id = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}