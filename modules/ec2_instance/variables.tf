variable "first_subnet" {
  type = string
}

variable "first_subnet_public" {
  type = string
}

variable "second_subnet" {
  type = string
}

variable "first_sg" {
  type = set(string)
}

variable "second_sg" {
  type = set(string)
}

variable "instance_type" {
  default = "t2.micro"
}

variable "first_ami" {
  default = "ami-02675d30b814d1daa"
}

variable "sec_ami" {
  default = "ami-01973462ceff35e85"
}

variable "creator_key_pair" {
  type    = string
  default = "dz-keypair"
}

variable "ubuntu_data_file" {
  type    = string
  default = "serverData.tpl"
}

variable "keypair_file" {
  type    = string
}