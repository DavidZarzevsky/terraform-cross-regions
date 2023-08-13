variable "first_subnet_private" {
  type = string
}

variable "first_subnet_public" {
  type = string
}

variable "first_stransit_gw" {
  type = string
}

variable "first_sg" {
  type = string
}

variable "first_vpc" {
  type = string
}

variable "public_subnet_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "client_cidr_block" {
  type    = string
  default = "10.200.0.0/16"
}

variable "google_open_dns" {
  type    = string
  default = "8.8.8.8"
}

variable "all_traffic_to_network" {
  type = string
  default = "10.0.0.0/16"
}

variable "certificate_body" {
  type = string
  default = "~/custom_folder/server.crt"
}

variable "private_key" {
  type = string
  default = "~/custom_folder/server.key"
}

variable "certificate_chain" {
  type = string
  default = "~/custom_folder/ca.crt"
}

variable "client_certificate_body" {
  type = string
  default = "~/custom_folder/client1.domain.tld.crt"
}

variable "client_private_key" {
  type = string
  default = "~/custom_folder/client1.domain.tld.key"
}

variable "client_certificate_chain" {
  type = string
  default = "~/custom_folder/ca.crt"
}
