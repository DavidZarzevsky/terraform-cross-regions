variable "first_vpc_id" {
  type = string
}

variable "second_vpc_id" {
  type = string
}

variable "first_private_subnet" {
  type = string
}

variable "first_public_subnet" {
  type = string
}

variable "second_private_subnet" {
  type = string
}

variable "aws_first_region" {
  default = "us-east-1"
}

variable "aws_second_region" {
  default = "us-west-1"
}

variable "second_cider" {
  default = "10.2.0.0/16"
}

variable "first_cider" {
  default = "10.1.0.0/16"
}

variable "name" {
  type = string
}