variable "aws_access_key" {
  default = "AKIAICX7GWHUUNHHZWLA"
}

variable "aws_secret_key" {
  default = "wN5HHWZ8toahjFrXjs6vSqPXZlh6YPAZ9fMowFwo"
}

variable "aws_region" {
  default = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default = "192.168.0.0/16"
}

variable "subnet_cidr" {
  description = "SUBNET CIDR"
  default = "192.168.0.0/24"
}

variable "key_name" {
  description = "Name of AWS Key Pair"
  default = "ITRS_MNL_ENG"
}
