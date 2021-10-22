resource "aws_lb_target_group" "target_group" {
  health_check {
    interval          = 10
    path              = "/"
    protocol          = "HTTP"
    timeout           = 5
    healthy_threshold = 5
  }

  name          = "my-tg"
  port          = 80
  protocol      = "HTTP"
  target_type   = "instance"
  vpc_id        = aws_vpc.vpc.id
}

resource "aws_lb" "my_alb" {
  name                       = "my-alb"
  load_balancer_type         = "application"
  security_groups            = [ "${aws_security_group.alb_sg.id}" ]
  subnets                    = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    name = "my_alb"
  }
}

resource "aws_lb_listener" "ald_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
  }
}

resource "aws_lb_target_group_attachment" "ec2_attach" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id = aws_instance.ec2.id
}