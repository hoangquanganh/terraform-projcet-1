output "bastion_ip" {
    value     = "${aws_instance.bastion.public_ip}"
}

output "bastion_dns" {
  value       = "${aws_instance.bastion.public_dns}"
}

# ec2 public ip, dns
output "ec2_ip" {
  description = "The public ip for ssh access"
  value       = aws_instance.ec2.public_ip
}

output "dns" {
    description  = "The public dns of ec2"
    value        = aws_instance.ec2.public_dns
}