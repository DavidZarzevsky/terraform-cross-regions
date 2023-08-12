# Define an AWS EC2 Client VPN endpoint
resource "aws_ec2_client_vpn_endpoint" "first" {
  provider = aws.first
  description = "Client VPN for David"
  server_certificate_arn = aws_acm_certificate.server_vpn_cert.arn
  authentication_options {
    type = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client_vpn_cert.arn
  }
  connection_log_options {
    enabled = false
  }
  split_tunnel = true
  security_group_ids     = [aws_security_group.vpn_secgroup.id]
  vpc_id = var.first_vpc
  client_cidr_block      = var.client_cidr_block
  dns_servers = [var.google_open_dns]
  tags = {
    Name = "David-ClientVPN"
  }
  depends_on = [
    aws_acm_certificate.server_vpn_cert,
    aws_acm_certificate.client_vpn_cert
  ]
}

# Associate the Client VPN endpoint with the public subnet
resource "aws_ec2_client_vpn_network_association" "transit_first" {
  provider               = aws.first
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.first.id
  subnet_id              = var.first_subnet_public
}

# Define an authorization rule for the Client VPN endpoint (authorize all traffic to target networks)
resource "aws_ec2_client_vpn_authorization_rule" "first" {
  provider = aws.first
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.first.id
  target_network_cidr    = var.all_traffic_to_network
  authorize_all_groups   = true
}

## Define another authorization rule for the Client VPN endpoint
#resource "aws_ec2_client_vpn_authorization_rule" "first_1" {
#  provider = aws.first
#  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.first.id
#  target_network_cidr    = "10.1.0.0/16"
#  authorize_all_groups   = true
#}

# Associate the Client VPN endpoint with private and public subnets
resource "aws_ec2_client_vpn_network_association" "client_vpn_association_private" {
  provider = aws.first
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.first.id
  subnet_id              = var.first_subnet_private
}

resource "aws_ec2_client_vpn_network_association" "client_vpn_association_public" {
  provider = aws.first
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.first.id
  subnet_id              = var.first_subnet_public
}

# Define an AWS security group for the VPN
resource "aws_security_group" "vpn_secgroup" {
  provider = aws.first
  name   = "vpn-sg"
  vpc_id = var.first_vpc
  description = "Allow inbound traffic from port 443, to the VPN"

  ingress {
   protocol         = "tcp"
   from_port        = 443
   to_port          = 443
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
}

# Define an ACM certificate for the VPN server
resource "aws_acm_certificate" "server_vpn_cert" {
 provider = aws.first
 certificate_body  = var.certificate_body
 private_key       = var.private_key
 certificate_chain = var.certificate_chain
}

# Define an ACM certificate for the VPN client
resource "aws_acm_certificate" "client_vpn_cert" {
 provider = aws.first
  certificate_body  = var.client_certificate_body
  private_key       = var.client_private_key
  certificate_chain = var.client_certificate_chain
}
