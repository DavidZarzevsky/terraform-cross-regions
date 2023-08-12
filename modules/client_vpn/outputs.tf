output "client_vpn_endpoint_id" {
  value = aws_ec2_client_vpn_endpoint.first.id
}

output "vpn_security_group_id" {
  value = aws_security_group.vpn_secgroup.id
}

output "server_vpn_certificate_arn" {
  value = aws_acm_certificate.server_vpn_cert.arn
}

output "client_vpn_certificate_arn" {
  value = aws_acm_certificate.client_vpn_cert.arn
}
