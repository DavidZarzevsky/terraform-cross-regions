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
  type    = string
  default = "10.200.0.0/16"
}

variable "all_traffic_to_network" {
  description = "CIDR block representing the target network for all traffic"
  type        = string
  default     = "10.0.0.0/16"
}

variable "certificate_body" {
  description = "Path to the server's SSL/TLS certificate body file"
  type        = string
  default     = "~/custom_folder/server.crt"
}

variable "server_private_key" {
  description = "Path to the server's SSL/TLS private key file"
  type        = string
  default     = "~/custom_folder/server.key"
}

variable "certificate_chain" {
  description = "Path to the SSL/TLS certificate chain file"
  type        = string
  default     = "~/custom_folder/ca.crt"
}

variable "client_certificate_body" {
  description = "Path to the client's SSL/TLS certificate body file"
  type        = string
  default     = "~/custom_folder/client1.domain.tld.crt"
}

variable "client_private_key" {
  description = "Path to the client's SSL/TLS private key file"
  type        = string
  default     = "~/custom_folder/client1.domain.tld.key"
}

variable "open_dns_address" {
  description = "OpenDNS IP address"
  type        = string
  default     = "8.8.8.8"
}



