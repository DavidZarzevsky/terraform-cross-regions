
variable "src_private_subnet_az" {
  default = "us-east-1a"
}

variable "dst_private_subnet_az" {
  default = "us-west-1a"
}

variable "src_public_subnet_az" {
  default = "us-east-1b"
}

variable "src_vpc_id" {
  type = string
}

variable "dst_vpc_id" {
  type = string
}

variable "src_private_subnet_cidr_block" {
  type    = string
  default = "10.1.1.0/24"
}

variable "src_public_subnet_cidr_block" {
  type    = string
  default = "10.1.0.0/24"
}

variable "dst_private_subnet_cidr_block" {
  type    = string
  default = "10.2.1.0/24"
}

variable "all_traffic" {
  type    = string
  default = "0.0.0.0/0"
}

variable "igw" {
  type = string
}

