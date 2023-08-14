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
  source  = "./modules/vpc"
  src_tgw = module.peering.src_transit_gateway_id
  dst_tgw = module.peering.dst_transit_gateway_id
  name    = var.name
}

# Instantiate the Subnet module with custom providers
module "subnet" {
  providers = {
    aws.src = aws.src
    aws.dst = aws.dst
  }
  source     = "./modules/subnet"
  src_vpc_id = module.vpc.src_vpc_id
  dst_vpc_id = module.vpc.dst_vpc_id
  igw        = module.peering.src_internet_gateway_id
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
}

# Instantiate the Security Group module with custom providers
module "security_group" {
  providers = {
    aws.src = aws.src
    aws.dst = aws.dst
  }
  source     = "./modules/security_group"
  src_vpc_id = module.vpc.src_vpc_id
  dst_vpc_id = module.vpc.dst_vpc_id
  name       = var.name
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
}

# Instantiate the Client VPN module with custom providers
module "client_vpn" {
  providers = {
    aws.src = aws.src
    aws.dst = aws.dst
  }
  source             = "./modules/client_vpn"
  src_sg             = module.security_group.src_security_group_id
  src_stransit_gw    = module.peering.src_transit_gateway_id
  src_subnet_private = module.subnet.src_private_subnet_id
  src_subnet_public  = module.subnet.src_public_subnet_id
  src_vpc            = module.vpc.src_vpc_id
  name               = var.name
  all_traffic_to_network = var.all_traffic_to_network
  certificate_body = var.certificate_body
  certificate_chain = var.certificate_chain
  client_certificate_body = var.client_certificate_body
  client_certificate_chain = var.certificate_chain
  client_cidr_block = var.client_cidr_block
  client_private_key = var.client_private_key
  open_dns = var.open_dns_address
  private_key = var.server_private_key
}

resource "null_resource" "export_clients_vpn_config" {
  depends_on = [module.client_vpn]

  provisioner "local-exec" {
    environment = {
      "CLIENT_VPN_ID"    = module.client_vpn.client_vpn_endpoint_id
      "CLIENT_CERT_NAME" = "${var.name}-cert"
      "TENANT_NAME" = "aws"
      "KEY_SAVE_FOLDER" = "/Users/dzarzevs/custom_folder"
      "ENV" = var.aws_src_profile
      "REGION" = var.aws_src_region
    }
    command = "${path.module}/getVPN.sh"
  }
}
