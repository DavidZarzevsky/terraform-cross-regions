# Define AWS EC2 Transit Gateway for the first account
resource "aws_ec2_transit_gateway" "first" {
  provider  = aws.first
  tags = {
    Name    = "David-first"
  }
}

# Define AWS EC2 Transit Gateway for the second account
resource "aws_ec2_transit_gateway" "second" {
  provider  = aws.second
  tags = {
    Name    = "David-second"
  }
}

# Fetch caller identity information for the first account
data "aws_caller_identity" "first" {
  provider = aws.first
}

# Create a peering attachment from the second account to the first account's Transit Gateway
resource "aws_ec2_transit_gateway_peering_attachment" "gtw_peer" {
  provider                = aws.second
  peer_account_id         = data.aws_caller_identity.first.account_id
  peer_region             = var.aws_first_region
  peer_transit_gateway_id = aws_ec2_transit_gateway.first.id
  transit_gateway_id      = aws_ec2_transit_gateway.second.id
  tags = {
    Name = "David"
    Side = "Creator"
  }
}

# Accept the peering attachment on the first account's side
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "peer_attach" {
  provider                      = aws.first
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.gtw_peer.id
  tags = {
    Name = "David"
    Side = "Acceptor"
  }
}

# Attach the first account VPC to the first account's Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "first"{
  provider                      = aws.first
  transit_gateway_id            = aws_ec2_transit_gateway.first.id
  vpc_id                        = var.first_vpc_id
  subnet_ids                    = [var.first_public_subnet, var.first_private_subnet]
  tags = {
    Name = "David"
  }
}

# Attach the second account VPC to the second account's Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "second"{
  provider                      = aws.second
  transit_gateway_id            = aws_ec2_transit_gateway.second.id
  vpc_id                        = var.second_vpc_id
  subnet_ids                    = [var.second_private_subnet]
  tags = {
    Name = "David"
  }
}

# Create an AWS Internet Gateway for the first account's VPC
resource "aws_internet_gateway" "first" {
  provider      = aws.first
  vpc_id        = var.first_vpc_id
  tags = {
    Name        = "David-first"
  }
}

# Create a static route in the first account's Transit Gateway for the peered network

resource "aws_ec2_transit_gateway_route" "static_peering_first" {
  provider           = aws.first
  destination_cidr_block = var.second_cider
  transit_gateway_route_table_id = aws_ec2_transit_gateway.first.association_default_route_table_id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.gtw_peer.id
  depends_on = [aws_ec2_transit_gateway_peering_attachment_accepter.peer_attach]
}

# Create a static route in the second account's Transit Gateway for the peered network

resource "aws_ec2_transit_gateway_route" "static_peering_second" {
  provider           = aws.second
  destination_cidr_block = var.first_cider
  transit_gateway_route_table_id = aws_ec2_transit_gateway.second.association_default_route_table_id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.gtw_peer.id
}


/*
We went through the configuration and made the changes below to the US-East-1 account:

- Added a route to vpc-first route table sending 10.2.0.0/16 to the TGW
- Added a route to tgw-rtb-0de06b5aa5b77ed61 to send 10.2.0.0/16 to the TGW Peering attachment and sending 10.1.0.0/16 to the vpc-077957e8817a9f6f0.

We went through the configuration and made the changes below to the US-West-1 account:

- Added a route to vpc-second route table sending 10.1.0.0/16 traffic to the TGW
- Added routes to tgw-rtb-0b0cb1b1dfd87489e sending 10.1.0.0/16 to the TGW peering attachment and sending 10.2.0.0/16 to vpc-0775b3fd0898aa6e4

Copy the pem to the second instance
scp -i /Users/dzarzevs/.ssh/dz-key /Users/dzarzevs/.ssh/dz-key.pem ubuntu@10.1.1.109:~/

*/