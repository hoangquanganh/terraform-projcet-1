resource "aws_launch_template" "template" {
  name          = "template"
  image_id      = "ami-0d058fe428540cd89"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "autoscal" {
  capacity_rebalance   = true
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.private_1.id]
  health_check_type    = "EC2"
  force_delete         = true

  launch_template {
    id      =  aws_launch_template.template.id
    version = "$Latest"
  }

  tags = [ {
    key = "autoscal"
  } ]
}