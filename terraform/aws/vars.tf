# Provided by 'personal' terraform.tfvars
variable "aws_region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "path_to_private_key" {}
variable "instance_username" {}
variable "key_name" {}
variable "domain" {}
variable "aws_vpc_id" {}
# End Provided by 'personal' terraform.tfvars

variable "client_count" {
  default = 1
}

variable "ansible_path" {
  default = "../../ansible"
}

variable "region_ami" {
  type = map(any)

  default = {
    us-east-1 = "ami-0072100bb96764e35"
    us-east-2 = "ami-086a21e2f01d7216b"
    us-west-1 = "ami-00120ded1087b72bc"
    us-west-2 = "ami-022d4c35edd6e3c22"
  }
}


variable "instance_types" {
  type = map(any)

  default = {
    satellite = "t2.medium"
    oscap     = "t2.micro"
    client    = "t2.nano"
  }
}
