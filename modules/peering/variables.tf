variable "src_vpc_id" {
  type = string
}

variable "dst_vpc_id" {
  type = string
}

variable "src_private_subnet" {
  type = string
}

variable "src_public_subnet" {
  type = string
}

variable "dst_private_subnet" {
  type = string
}

variable "aws_src_region" {
  default = "us-east-1"
}

variable "aws_dst_region" {
  default = "us-west-1"
}

variable "dst_cider" {
  default = "10.2.0.0/16"
}

variable "src_cider" {
  default = "10.1.0.0/16"
}

variable "name" {
  type = string
}