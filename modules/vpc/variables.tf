variable "vpc_cidr_block_first" {
  type    = string
  default = "10.1.0.0/16"
}

variable "vpc_cidr_block_second" {
  type    = string
  default = "10.2.0.0/16"
}

variable "first_tgw" {
  type    = string
}

variable "second_tgw" {
  type    = string
}
