
variable "first_private_subnet_az" {
  default = "us-east-1a"
}

variable "second_private_subnet_az" {
  default = "us-west-1a"
}

variable "first_public_subnet_az" {
  default = "us-east-1b"
}

variable "first_vpc_id" {
  type = string
}

variable "second_vpc_id" {
  type = string
}

variable "first_private_subnet_cidr_block" {
  type    = string
  default = "10.1.1.0/24"
}

variable "first_public_subnet_cidr_block" {
  type    = string
  default = "10.1.0.0/24"
}

variable "second_private_subnet_cidr_block" {
  type    = string
  default = "10.2.1.0/24"
}

variable "all_traffic" {
  type    = string
  default = "0.0.0.0/0"
}

variable "igw" {
  type    = string
}

