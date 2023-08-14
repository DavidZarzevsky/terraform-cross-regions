# Define an AWS private subnet in the src account VPC
resource "aws_subnet" "src_private" {
  provider          = aws.src
  vpc_id            = var.src_vpc_id
  cidr_block        = var.src_private_subnet_cidr_block
  availability_zone = "${var.src_region}a"
  tags = {
    Name = "${var.name}_src_private"
  }
}

# Define an AWS public subnet in the src account VPC
resource "aws_subnet" "src_public" {
  provider          = aws.src
  vpc_id            = var.src_vpc_id
  cidr_block        = var.src_public_subnet_cidr_block
  availability_zone = "${var.src_region}b"
  tags = {
    Name = "${var.name}-src-public"
  }
}

# Define an AWS private subnet in the dst account VPC
resource "aws_subnet" "dst_private" {
  provider          = aws.dst
  vpc_id            = var.dst_vpc_id
  cidr_block        = var.dst_private_subnet_cidr_block
  availability_zone = "${var.dst_region}a"
  tags = {
    Name = "${var.name}_dst_private"
  }
}

# Define an AWS public route table in the src account VPC
resource "aws_route_table" "public" {
  provider = aws.src
  vpc_id   = var.src_vpc_id
  route {
    cidr_block = var.igw_network_traffic
    gateway_id = var.igw
  }
  tags = {
    Name = "${var.name}_src_rt"
  }
}

# Associate the public route table with the src public subnet
resource "aws_route_table_association" "public" {
  provider       = aws.src
  subnet_id      = aws_subnet.src_public.id
  route_table_id = aws_route_table.public.id
}
