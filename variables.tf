variable "name" {
    type        = string
    description = "Your name"
    default     = "David"
}

variable "aws_first_region" {
  type        = string
  description = "Your first account region"
  default     = "us-east-1"
}

variable "aws_second_region" {
  type        = string
  description = "Your second account region"
  default     = "us-west-1"
}

variable "aws_first_profile" {
    type    = string
    description = "Your first AWS profile alias"
    default = "SRE"
}

variable "aws_second_profile" {
    type    = string
    description = "Your first AWS profile alias"
    default = "default"
}

variable "keypair_file_path" {
  type    = string
  description = "Your keypair local path"
  default = "/Users/dzarzevs/.ssh/dz-key.pub"
}



