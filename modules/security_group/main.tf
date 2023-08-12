# Define an AWS security group in the first account VPC
resource "aws_security_group" "first" {
  provider     = aws.first
  name         = "david_security_group_f"
  description  = "david_security_group"
  vpc_id       = var.first_vpc_id
  # Define an ingress rule to allow inbound SSH traffic
  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr_block]
  }
  # Define an egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr_block]
  }
  tags = {
    Name = "david_first_security_group"
  }
}

# Define an AWS security group in the second account VPC
resource "aws_security_group" "second" {
  provider     = aws.second
  name         = "david_security_group_s"
  description  = "david_security_group"
  vpc_id       = var.second_vpc_id
  # Define an ingress rule to deny all inbound traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr_block]
  }
  # Define an egress rule to deny all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr_block]
  }
  tags = {
    Name = "david_second_security_group"
  }
}
