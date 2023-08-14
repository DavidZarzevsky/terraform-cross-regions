variable "name" {
  type        = string
  description = "Your name"
  default     = "David"
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
  default     = "SRE"
}

variable "aws_dst_profile" {
  type        = string
  description = "Your destination AWS profile alias"
  default     = "default"
}

variable "keypair_file_path" {
  type        = string
  description = "Your keypair local path"
  default     = "/Users/dzarzevs/.ssh/dz-key.pub"
}

variable "client_cidr_block" {
  description = "VPN client CIDR block"
  type        = string
  default     = "10.200.0.0/16"
}

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

variable "all_traffic_to_network" {
  description = "CIDR block representing the target network for all traffic"
  type        = string
  default     = "10.0.0.0/16"
}

variable "open_dns_address" {
  description = "OpenDNS IP address"
  type        = string
  default     = "8.8.8.8"
}

variable "key_save_folder" {
  description = "Where to store keys (relative to pki folder)"
  type        = string
  default     = "clientvpn_keys"
}

variable "env" {
  description = "Your account environment"
  type        = string
  default     = "prod"
}


