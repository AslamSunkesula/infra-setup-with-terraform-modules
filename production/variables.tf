# variable "vpc_name" {}
# variable "vpc_cidr" {}
# variable "environment" {}
# variable "public_subnet_cidr" {}
# variable "private_subnet_cidr" {}
# variable "azs" {}
# variable "aws_region" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "172.22.0.0/16"
}

variable "vpc_name" {
  default = "prod_vpc_1"
}

variable "environment" {
  default = "Production"
}

variable "public_subnet_cidr" {
  default = ["172.22.1.0/24", "172.22.2.0/24", "172.22.3.0/24"]
}

variable "private_subnet_cidr" {
  default = ["172.22.10.0/24", "172.22.20.0/24", "172.22.30.0/24"]
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
