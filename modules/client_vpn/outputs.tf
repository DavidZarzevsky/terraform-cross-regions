output "client_vpn_endpoint_id" {
  value = aws_ec2_client_vpn_endpoint.src.id
}

output "client_vpn_endpoint_login" {
  value = aws_ec2_client_vpn_endpoint.src.connection_log_options
}

output "vpn_security_group_id" {
  value = aws_security_group.vpn_secgroup.id
}
