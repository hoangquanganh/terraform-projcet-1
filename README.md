# terraform-projcet-1
create a aws model includes 1 vpc, 02 public subnet, 02 private subnet ,01 bastion server in public subnet, 
1 ec2 webserver running nginx, php laravel connected to 1 rds mysql, in private subnet, ec2 web only ssh form bastion and open full http 80.
1 autoscaling group to modify template of ec2 web server, build 1 ALB for ec2 web.
