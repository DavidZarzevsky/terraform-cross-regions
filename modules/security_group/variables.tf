variable "src_vpc_id" {
  type = string
}

variable "dst_vpc_id" {
  type = string
}

variable "all_cidr_block" {
  default = "0.0.0.0/0"
}

variable "name" {
  type = string
}
