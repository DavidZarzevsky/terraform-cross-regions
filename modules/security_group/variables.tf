variable "src_vpc_id" {
  type = string
}

variable "dst_vpc_id" {
  type = string
}

variable "sg_ingress_cidr_block" {
  type = string
}

variable "sg_egress_cidr_block" {
  type = string
}

variable "name" {
  type = string
}
