# Define the src AWS VPC in the src account
resource "aws_vpc" "src" {
  provider   = aws.src
  cidr_block = var.vpc_cidr_block_src
  tags = {
    Name = "${var.name}-src"
  }
}

# Create a route in the src VPC's default route table, sending traffic to a transit gateway
resource "aws_route" "send_to_tgw1" {
  provider               = aws.src
  route_table_id         = aws_vpc.src.default_route_table_id
  destination_cidr_block = var.vpc_cidr_block_dst
  transit_gateway_id     = var.src_tgw
  depends_on             = [aws_vpc.src, var.src_tgw]
}

# Define the dst AWS VPC in the dst account
resource "aws_vpc" "dst" {
  provider   = aws.dst
  cidr_block = var.vpc_cidr_block_dst
  tags = {
    Name = "${var.name}-dst"
  }
}

# Create a route in the dst VPC's default route table, sending traffic to the dst transit gateway
resource "aws_route" "send_to_tgw2" {
  provider               = aws.dst
  route_table_id         = aws_vpc.dst.default_route_table_id
  destination_cidr_block = var.vpc_cidr_block_src
  transit_gateway_id     = var.dst_tgw
  depends_on             = [aws_vpc.dst, var.dst_tgw]
}
