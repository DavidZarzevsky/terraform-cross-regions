# Define AWS provider for the src region and account
provider "aws" {
  alias   = "src"
  region  = var.aws_src_region
  profile = var.aws_src_profile
}

# Define AWS provider for the dst region and account
provider "aws" {
  alias   = "dst"
  region  = var.aws_dst_region
  profile = var.aws_dst_profile
}

# Instantiate the VPC module with custom providers
module "vpc" {
  providers = {
    aws.src = aws.src
    aws.dst = aws.dst
  }
  source             = "./modules/vpc"
  src_tgw            = module.peering.src_transit_gateway_id
  dst_tgw            = module.peering.dst_transit_gateway_id
  name               = var.name
  vpc_cidr_block_dst = var.vpc_cidr_block_dst
  vpc_cidr_block_src = var.vpc_cidr_block_src
}

# Instantiate the Subnet module with custom providers
module "subnet" {
  providers = {
    aws.src = aws.src
    aws.dst = aws.dst
  }
  source                        = "./modules/subnet"
  src_vpc_id                    = module.vpc.src_vpc_id
  dst_vpc_id                    = module.vpc.dst_vpc_id
  igw                           = module.peering.src_internet_gateway_id
  igw_network_traffic           = var.igw_network_traffic
  name                          = var.name
  dst_private_subnet_cidr_block = var.dst_private_subnet_cidr_block
  src_private_subnet_cidr_block = var.src_private_subnet_cidr_block
  src_public_subnet_cidr_block  = var.src_public_subnet_cidr_block
  dst_region                    = var.aws_dst_region
  src_region                    = var.aws_src_region
}

# Instantiate the Peering module with custom providers
module "peering" {
  providers = {
    aws.src = aws.src
    aws.dst = aws.dst
  }
  source             = "./modules/peering"
  src_vpc_id         = module.vpc.src_vpc_id
  dst_vpc_id         = module.vpc.dst_vpc_id
  src_private_subnet = module.subnet.src_private_subnet_id
  src_public_subnet  = module.subnet.src_public_subnet_id
  dst_private_subnet = module.subnet.dst_private_subnet_id
  name               = var.name
  aws_dst_region     = var.aws_dst_region
  aws_src_region     = var.aws_src_region
  dst_cider          = var.vpc_cidr_block_dst
  src_cider          = var.vpc_cidr_block_src
}

# Instantiate the Security Group module with custom providers
module "security_group" {
  providers = {
    aws.src = aws.src
    aws.dst = aws.dst
  }
  source                = "./modules/security_group"
  src_vpc_id            = module.vpc.src_vpc_id
  dst_vpc_id            = module.vpc.dst_vpc_id
  name                  = var.name
  sg_egress_cidr_block  = var.sg_egress_cidr_block
  sg_ingress_cidr_block = var.sg_ingress_cidr_block
}

# Instantiate the EC2 Instance module with custom providers
module "ec2_instance" {
  providers = {
    aws.src = aws.src
    aws.dst = aws.dst
  }
  source            = "./modules/ec2_instance"
  src_sg            = [module.security_group.src_security_group_id]
  src_subnet        = module.subnet.src_private_subnet_id
  dst_sg            = [module.security_group.dst_security_group_id]
  dst_subnet        = module.subnet.dst_private_subnet_id
  src_subnet_public = module.subnet.src_public_subnet_id
  keypair_file      = var.keypair_file_path
  name              = var.name
  instance_type     = var.instance_type
  dst_region_ami    = var.dst_region_ami
  src_region_ami    = var.src_region_ami
}

# Instantiate the Client VPN module with custom providers
module "client_vpn" {
  providers = {
    aws.src = aws.src
    aws.dst = aws.dst
  }
  source                 = "./modules/client_vpn"
  src_sg                 = module.security_group.src_security_group_id
  src_stransit_gw        = module.peering.src_transit_gateway_id
  src_subnet_private     = module.subnet.src_private_subnet_id
  src_subnet_public      = module.subnet.src_public_subnet_id
  src_vpc                = module.vpc.src_vpc_id
  name                   = var.name
  all_traffic_to_network = var.authorize_client_target_network_cidr
  client_cidr_block      = var.client_cidr_block
  open_dns               = var.VPN_dns_address
  key_save_folder        = var.key_save_folder
  aws_src_region         = var.aws_src_region
  aws_src_profile        = var.aws_src_profile
  env                    = var.env
}
