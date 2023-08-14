locals {
  provisioner_base_env = {
    "CERT_ISSUER"     = var.name
    "KEY_SAVE_FOLDER" = var.key_save_folder
    "REGION"          = var.aws_src_region
    "PKI_FOLDER_NAME" = "pki_new"
    "ENV"             = var.env
    "TARGET_CIDR"     = var.all_traffic_to_network
    "MODULE_PATH"     = path.module
    "CONCURRENCY"     = "true"
    "AWSCLIPROFILE"   = var.aws_src_profile
  }
}

# Prepare EasyRSA scripts for server certificate generation
resource "null_resource" "server_certificate" {
  provisioner "local-exec" {
    environment = merge(local.provisioner_base_env, {
    })
    command = "modules/scripts/prepare_easyrsa.sh"
  }
}

# Generate client certificate using EasyRSA scripts
resource "null_resource" "client_certificate" {
  depends_on = [aws_acm_certificate.server_cert]

  provisioner "local-exec" {
    environment = local.provisioner_base_env
    command     = "modules/scripts/create_client.sh"
  }
}

# Retrieve server private key content from local file
data "local_file" "server_private_key" {
  depends_on = [null_resource.server_certificate]
  filename   = null_resource.server_certificate.id > 0 ? "pki_new/${var.key_save_folder}/server.key" : ""
}

# Retrieve server certificate body content from local file
data "local_file" "server_certificate_body" {
  depends_on = [null_resource.server_certificate]
  filename   = null_resource.server_certificate.id > 0 ? "pki_new/${var.key_save_folder}/server.crt" : ""
}

# Retrieve server certificate chain content from local file
data "local_file" "server_certificate_chain" {
  depends_on = [null_resource.server_certificate]
  filename   = null_resource.server_certificate.id > 0 ? "pki_new/${var.key_save_folder}/ca.crt" : ""
}

# Create an AWS ACM certificate for the server
resource "aws_acm_certificate" "server_cert" {
  provider   = aws.src
  depends_on = [null_resource.server_certificate]

  private_key       = data.local_file.server_private_key.content
  certificate_body  = data.local_file.server_certificate_body.content
  certificate_chain = data.local_file.server_certificate_chain.content

  lifecycle {
    ignore_changes = [options, private_key, certificate_body, certificate_chain]
  }
  tags = {
    Name = "${var.name}_server"
  }
}


# Define an AWS EC2 Client VPN endpoint
resource "aws_ec2_client_vpn_endpoint" "src" {
  provider               = aws.src
  description            = "${var.name} Client VPN"
  server_certificate_arn = aws_acm_certificate.server_cert.arn
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.server_cert.arn
  }
  provisioner "local-exec" {
    environment = merge(local.provisioner_base_env, {
      "CLIENT_VPN_ID" = self.id
    })
    command = "modules/scripts/authorize_client.sh"
  }
  connection_log_options {
    enabled = false
  }
  split_tunnel       = true
  security_group_ids = [aws_security_group.vpn_secgroup.id]
  vpc_id             = var.src_vpc
  client_cidr_block  = var.client_cidr_block
  dns_servers        = [var.open_dns]
  tags = {
    Name = "${var.name}-ClientVPN"
  }
  depends_on = [
    aws_acm_certificate.server_cert
  ]
}

resource "null_resource" "export_clients_vpn_config" {
  depends_on = [null_resource.client_certificate, aws_ec2_client_vpn_endpoint.src]

  provisioner "local-exec" {
    environment = merge(local.provisioner_base_env, {
      "CLIENT_VPN_ID"    = aws_ec2_client_vpn_endpoint.src.id
      "CLIENT_CERT_NAME" = "${var.name}-cert"
      "TENANT_NAME"      = "AWS"
    })
    command = "modules/scripts/getVPN.sh"
  }
}

# Define an authorization rule for the Client VPN endpoint (authorize all traffic to target networks)
resource "aws_ec2_client_vpn_authorization_rule" "src" {
  provider               = aws.src
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.src.id
  target_network_cidr    = "10.1.0.0/16"
  authorize_all_groups   = true
}

# Associate the Client VPN endpoint with private and public subnets
resource "aws_ec2_client_vpn_network_association" "client_vpn_association_private" {
  provider               = aws.src
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.src.id
  subnet_id              = var.src_subnet_private
}

resource "aws_ec2_client_vpn_network_association" "client_vpn_association_public" {
  provider               = aws.src
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.src.id
  subnet_id              = var.src_subnet_public
}

# Define an AWS security group for the VPN
resource "aws_security_group" "vpn_secgroup" {
  provider    = aws.src
  name        = "${var.name}-vpn-sg"
  vpc_id      = var.src_vpc
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

