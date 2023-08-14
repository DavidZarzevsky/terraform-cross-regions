variable "src_subnet_private" {
  type = string
}

variable "src_subnet_public" {
  type = string
}

variable "src_stransit_gw" {
  type = string
}

variable "src_sg" {
  type = string
}

variable "src_vpc" {
  type = string
}

variable "client_cidr_block" {
  type    = string
}

variable "open_dns" {
  type    = string
}

variable "all_traffic_to_network" {
  type    = string
}

variable "certificate_body" {
  type    = string
}

variable "private_key" {
  type    = string
}

variable "certificate_chain" {
  type    = string
}

variable "client_certificate_body" {
  type    = string
}

variable "client_private_key" {
  type    = string
}

variable "client_certificate_chain" {
  type    = string
}

variable "name" {
  type = string
}