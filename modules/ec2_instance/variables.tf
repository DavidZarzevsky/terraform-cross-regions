variable "src_subnet" {
  type = string
}

variable "src_subnet_public" {
  type = string
}

variable "dst_subnet" {
  type = string
}

variable "src_sg" {
  type = set(string)
}

variable "dst_sg" {
  type = set(string)
}

variable "instance_type" {
  type = string
}

variable "src_region_ami" {
  type = string
}

variable "dst_region_ami" {
  type = string
}

variable "ubuntu_data_file" {
  type    = string
  default = "serverData.tpl"
}

variable "keypair_file" {
  type = string
}

variable "name" {
  type = string
}