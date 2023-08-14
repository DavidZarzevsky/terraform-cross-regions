######################## environment vars ########################

variable "name" {
  type        = string
  description = "Your name"
  default     = "name"
}

variable "env" {
  type        = string
  description = "Your account environment"
  default     = "prod"
}

variable "aws_src_region" {
  type        = string
  description = "Your source account region"
  default     = "us-east-1"
}

variable "aws_dst_region" {
  type        = string
  description = "Your destination account region"
  default     = "us-west-1"
}

variable "aws_src_profile" {
  type        = string
  description = "Your source AWS profile alias"
  default     = ""
}

variable "aws_dst_profile" {
  type        = string
  description = "Your destination AWS profile alias"
  default     = ""
}

######################## EC2 vars ########################

variable "keypair_file_path" {
  type        = string
  description = "Your keypair local path"
  default     = "/Users/israel/.ssh/il-key.pub"
}

variable "ami" {
  type        = string
  description = "Source instance AMI"
  default     = "ami-02675d30b814d1daa"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

######################## VPC vars ########################

variable "vpc_cidr_block_src" {
  description = "Source VPC CIDR block"
  type        = string
  default     = "10.1.0.0/16"
}

variable "vpc_cidr_block_dst" {
  description = "Destination VPC CIDR block"
  type        = string
  default     = "10.2.0.0/16"
}

######################## Subnets vars ########################

variable "src_private_subnet_cidr_block" {
  description = "Source private subnet CIDR block"
  type        = string
  default     = "10.1.1.0/24"
}

variable "src_public_subnet_cidr_block" {
  description = "Source public subnet CIDR block"
  type        = string
  default     = "10.1.0.0/24"
}

variable "dst_private_subnet_cidr_block" {
  description = "Destination public subnet CIDR block"
  type        = string
  default     = "10.2.1.0/24"
}

######################## Security group vars ########################

variable "sg_ingress_cidr_block" {
  description = "Security group ingress CIDR block"
  type        = string
  default     = "0.0.0.0/0"
}

variable "sg_egress_cidr_block" {
  description = "Security group egress CIDR block"
  type        = string
  default     = "0.0.0.0/0"
}

######################## VPN vars ########################

variable "client_cidr_block" {
  description = "VPN client CIDR block"
  type        = string
  default     = "10.200.0.0/16"
}

variable "authorize_client_target_network_cidr" {
  description = "CIDR block for the client target network authorization"
  type        = string
  default     = "10.0.0.0/16"
}

variable "VPN_dns_address" {
  description = "DNS IP address"
  type        = string
  default     = "8.8.8.8"
}

variable "key_save_folder" {
  description = "Client VPN keys folder name"
  type        = string
  default     = "clientvpn_keys"
}

######################## Internet gateway vars ########################

variable "igw_network_traffic" {
  description = "Internet gateway cider block for route table resource"
  type        = string
  default     = "0.0.0.0/0"
}

