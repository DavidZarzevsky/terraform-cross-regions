# Define AWS EC2 Transit Gateway for the src account
resource "aws_ec2_transit_gateway" "src" {
  provider = aws.src
  tags = {
    Name = "${var.name}-tgw-src"
  }
}

# Define AWS EC2 Transit Gateway for the dst account
resource "aws_ec2_transit_gateway" "dst" {
  provider = aws.dst
  tags = {
    Name = "${var.name}-tgw-dst"
  }
}

# Fetch caller identity information for the src account
data "aws_caller_identity" "src" {
  provider = aws.src
}

# Create a peering attachment from the dst account to the src account's Transit Gateway
resource "aws_ec2_transit_gateway_peering_attachment" "gtw_peer" {
  provider                = aws.dst
  peer_account_id         = data.aws_caller_identity.src.account_id
  peer_region             = var.aws_src_region
  peer_transit_gateway_id = aws_ec2_transit_gateway.src.id
  transit_gateway_id      = aws_ec2_transit_gateway.dst.id
  tags = {
    Name = "${var.name}-p.attachment"
    Side = "Creator"
  }
}

# Accept the peering attachment on the src account's side
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "peer_attach" {
  provider                      = aws.src
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.gtw_peer.id
  tags = {
    Name = "${var.name}-p.acceptor"
    Side = "Acceptor"
  }
}

# Attach the src account VPC to the src account's Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "src" {
  provider           = aws.src
  transit_gateway_id = aws_ec2_transit_gateway.src.id
  vpc_id             = var.src_vpc_id
  subnet_ids         = [var.src_public_subnet, var.src_private_subnet]
  tags = {
    Name = "${var.name}-vpc.attachment-src"
  }
}

# Attach the dst account VPC to the dst account's Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "dst" {
  provider           = aws.dst
  transit_gateway_id = aws_ec2_transit_gateway.dst.id
  vpc_id             = var.dst_vpc_id
  subnet_ids         = [var.dst_private_subnet]
  tags = {
    Name = "${var.name}-vpc.attachment-dst"
  }
}

# Create an AWS Internet Gateway for the src account's VPC
resource "aws_internet_gateway" "src" {
  provider = aws.src
  vpc_id   = var.src_vpc_id
  tags = {
    Name = "${var.name}-igw_src"
  }
}

# Create a static route in the src account's Transit Gateway for the peered network

resource "aws_ec2_transit_gateway_route" "static_peering_src" {
  provider                       = aws.src
  destination_cidr_block         = var.dst_cider
  transit_gateway_route_table_id = aws_ec2_transit_gateway.src.association_default_route_table_id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.gtw_peer.id
  depends_on                     = [aws_ec2_transit_gateway_peering_attachment_accepter.peer_attach]
}

# Create a static route in the dst account's Transit Gateway for the peered network

resource "aws_ec2_transit_gateway_route" "static_peering_dst" {
  provider                       = aws.dst
  destination_cidr_block         = var.src_cider
  transit_gateway_route_table_id = aws_ec2_transit_gateway.dst.association_default_route_table_id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.gtw_peer.id
  depends_on                     = [aws_ec2_transit_gateway_peering_attachment_accepter.peer_attach]
}
