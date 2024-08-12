# Define outputs for the public and private IP addresses
output "Public_IP_src_private_subnet" {
  value = module.ec2_instance.ServerPublicIP_src_private_subnet
}

output "Public_IP_src_public_subnet" {
  value = module.ec2_instance.ServerPublicIP_src_public_subnet
}

output "Public_IP_dst_private_subnet" {
  value = module.ec2_instance.ServerPublicIP_dst_private_subnet
}

output "Private_IP_src_private_subnet" {
  value = module.ec2_instance.ServerPrivateIP_src_private_subnet
}

output "Server_PrivateIP_dst_private_subnet" {
  value = module.ec2_instance.ServerPrivateIP_dst_private_subnet
}
