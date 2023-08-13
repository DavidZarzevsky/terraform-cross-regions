variable "aws_first_region" {
  default = "us-east-1"
}

variable "aws_second_region" {
  default = "us-west-1"
}

variable "aws_first_profile" {
    default = "SRE"
}
variable "aws_second_profile" {
    default = "default"
}

variable "keypair_file" {
  type    = string
  default = "/Users/dzarzevs/.ssh/dz-key.pub"
}
