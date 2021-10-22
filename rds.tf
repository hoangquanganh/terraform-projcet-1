# create a database subnet group
resource "aws_db_subnet_group" "mysql" {
  name                  = "mysql"
  description           = "Main group of private subnets"
  subnet_ids            = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    name = "mysql"
  }
}

# create a MySQL instance
resource "aws_db_instance" "mysql_db" {
  identifier              = "mysqldatabase"
  storage_type            = "gp2" # optional
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0" # optional
  instance_class          = "db.t2.micro"
  port                    = "3306" # optional
  db_subnet_group_name    = "${aws_db_subnet_group.mysql.name}"
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  name                    = "mysql_RDS" # optional
  username                = var.username
  password                = var.password
  # parameter_group_name  = "" # optional
  availability_zone       = "ap-southeast-1b" # optional
  publicly_accessible     = false # optional - by default it is false
  deletion_protection     = false # optional - by default it is false
  skip_final_snapshot     = true # optional

  tags = {
    name = "mySQL RDS Instance"
  }
}