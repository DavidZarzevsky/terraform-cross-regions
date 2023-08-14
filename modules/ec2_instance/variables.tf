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
  default = "t2.micro"
}

variable "src_ami" {
  default = "ami-02675d30b814d1daa"
}

variable "sec_ami" {
  default = "ami-01973462ceff35e85"
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