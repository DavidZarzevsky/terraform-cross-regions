# Define AWS provider for the first region and account
provider "aws" {
  alias   = "first"
  region  = var.aws_first_region
  profile = var.aws_first_profile
}

# Define AWS provider for the second region and account
provider "aws" {
  alias   = "second"
  region  = var.aws_second_region
  profile = var.aws_second_profile
}

# Instantiate the VPC module with custom providers
module "vpc" {
  providers = {
    aws.first   = aws.first
    aws.second  = aws.second
  }
  source = "./modules/vpc"
  first_tgw = module.peering.first_transit_gateway_id
  second_tgw = module.peering.second_transit_gateway_id
}

# Instantiate the Subnet module with custom providers
module "subnet" {
  providers = {
    aws.first   = aws.first
    aws.second  = aws.second
  }
  source = "./modules/subnet"
  first_vpc_id  = module.vpc.first_vpc_id
  second_vpc_id = module.vpc.second_vpc_id
  igw = module.peering.first_internet_gateway_id
}

# Instantiate the Peering module with custom providers
module "peering" {
  providers = {
    aws.first   = aws.first
    aws.second  = aws.second
  }
  source = "./modules/peering"
  first_vpc_id  = module.vpc.first_vpc_id
  second_vpc_id = module.vpc.second_vpc_id
  first_private_subnet = module.subnet.first_private_subnet_id
  first_public_subnet = module.subnet.first_public_subnet_id
  second_private_subnet = module.subnet.second_private_subnet_id
}

# Instantiate the Security Group module with custom providers
module "security_group" {
  providers = {
    aws.first   = aws.first
    aws.second  = aws.second
  }
  source = "./modules/security_group"
  first_vpc_id  = module.vpc.first_vpc_id
  second_vpc_id = module.vpc.second_vpc_id
}

# Instantiate the EC2 Instance module with custom providers
module "ec2_instance" {
  providers = {
    aws.first   = aws.first
    aws.second  = aws.second
  }
  source = "./modules/ec2_instance"
  first_sg = [module.security_group.first_security_group_id]
  first_subnet = module.subnet.first_private_subnet_id
  second_sg = [module.security_group.second_security_group_id]
  second_subnet = module.subnet.second_private_subnet_id
  first_subnet_public = module.subnet.first_public_subnet_id
}

# Instantiate the Client VPN module with custom providers
module "client_vpn" {
  providers = {
    aws.first   = aws.first
    aws.second  = aws.second
  }
  source = "./modules/client_vpn"
  first_sg = module.security_group.first_security_group_id
  first_stransit_gw = module.peering.first_transit_gateway_id
  first_subnet_private = module.subnet.first_private_subnet_id
  first_subnet_public = module.subnet.first_public_subnet_id
  first_vpc = module.vpc.first_vpc_id
}

# Define outputs for the public and private IP addresses
output "Public_IP_first_private_subnet" {
  value       = module.ec2_instance.ServerPublicIP_first_private_subnet
}

output "Public_IP_first_public_subnet" {
  value       = module.ec2_instance.ServerPublicIP_first_public_subnet
}

output "Public_IP_second_private_subnet" {
  value       = module.ec2_instance.ServerPublicIP_second_private_subnet
}

output "Private_IP_first_private_subnet" {
  value       = module.ec2_instance.ServerPrivateIP_first_private_subnet
}

output "Server_PrivateIP_second_private_subnet" {
  value       = module.ec2_instance.ServerPrivateIP_second_private_subnet
}
