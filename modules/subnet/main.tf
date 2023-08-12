# Define an AWS private subnet in the first account VPC
resource "aws_subnet" "first_private" {
  provider          = aws.first
  vpc_id            = var.first_vpc_id
  cidr_block        = var.first_private_subnet_cidr_block
  availability_zone = var.first_private_subnet_az
  tags = {
    Name = "David_first_private"
  }
}

# Define an AWS public subnet in the first account VPC
resource "aws_subnet" "first_public" {
  provider          = aws.first
  vpc_id            = var.first_vpc_id
  cidr_block        = var.first_public_subnet_cidr_block
  availability_zone = var.first_public_subnet_az
  tags = {
    Name = "David-first-public"
  }
}

# Define an AWS private subnet in the second account VPC
resource "aws_subnet" "second_private" {
  provider          = aws.second
  vpc_id            = var.second_vpc_id
  cidr_block        = var.second_private_subnet_cidr_block
  availability_zone = var.second_private_subnet_az
  tags = {
    Name = "David_second_private"
  }
}

# Define an AWS public route table in the first account VPC
resource "aws_route_table" "public" {
  provider     = aws.first
  vpc_id       = var.first_vpc_id
  route {
    cidr_block = var.all_traffic
    gateway_id = var.igw
  }
  tags = {
    Name = "David_first_rt"
  }
}

# Associate the public route table with the first public subnet
resource "aws_route_table_association" "public" {
  provider       = aws.first
  subnet_id      = aws_subnet.first_public.id
  route_table_id = aws_route_table.public.id
}
