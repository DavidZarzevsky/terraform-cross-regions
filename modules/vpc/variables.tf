variable "vpc_cidr_block_src" {
  type    = string
  default = "10.1.0.0/16"
}

variable "vpc_cidr_block_dst" {
  type    = string
  default = "10.2.0.0/16"
}

variable "src_tgw" {
  type = string
}

variable "dst_tgw" {
  type = string
}

variable "name" {
  type = string
}