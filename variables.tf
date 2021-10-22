# region
variable "aws_region" {
  description = "The AWS region to create services in."
  default     = "ap-southeast-1"
}

#cidr
variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "0.0.0.0/0"
}

#user
variable "username" {
  default = "admin"
}

variable "password" {
  default = "taolaanh99"
}