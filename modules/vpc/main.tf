# Define the first AWS VPC in the first account
resource "aws_vpc" "first" {
  provider    = aws.first
  cidr_block  = var.vpc_cidr_block_first
  tags = {
    Name      = "${var.name}-first"
  }
}

# Create a route in the first VPC's default route table, sending traffic to a transit gateway
resource "aws_route" "send_to_tgw1" {
  provider    = aws.first
  route_table_id = aws_vpc.first.default_route_table_id
  destination_cidr_block    = var.vpc_cidr_block_second
  transit_gateway_id  = var.first_tgw
  depends_on = [aws_vpc.first, var.first_tgw]
}

# Define the second AWS VPC in the second account
resource "aws_vpc" "second" {
  provider    = aws.second
  cidr_block  = var.vpc_cidr_block_second
  tags = {
    Name      = "${var.name}-second"
  }
}

# Create a route in the second VPC's default route table, sending traffic to the second transit gateway
resource "aws_route" "send_to_tgw2" {
  provider    = aws.second
  route_table_id = aws_vpc.second.default_route_table_id
  destination_cidr_block    = var.vpc_cidr_block_first
  transit_gateway_id  = var.second_tgw
  depends_on = [aws_vpc.second, var.second_tgw]
}
