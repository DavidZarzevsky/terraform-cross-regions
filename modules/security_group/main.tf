# Define an AWS security group in the src account VPC
resource "aws_security_group" "src" {
  provider = aws.src
  name     = "${var.name}_security_group_src"
  vpc_id   = var.src_vpc_id
  # Define an ingress rule to allow inbound SSH traffic
  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.sg_ingress_cidr_block]
  }
  # Define an egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.sg_egress_cidr_block]
  }
  tags = {
    Name = "${var.name}_src_security_group"
  }
}

# Define an AWS security group in the dst account VPC
resource "aws_security_group" "dst" {
  provider = aws.dst
  name     = "${var.name}_security_group_dst"
  vpc_id   = var.dst_vpc_id
  # Define an ingress rule to deny all inbound traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.sg_ingress_cidr_block]
  }
  # Define an egress rule to deny all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.sg_egress_cidr_block]
  }
  tags = {
    Name = "${var.name}_security_group_dst"
  }
}
