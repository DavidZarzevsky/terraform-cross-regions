# Define an AWS instance in the first VPC private subnet
resource "aws_instance" "first_instance_private" {
  provider                    = aws.first
  ami                         = var.first_ami
  instance_type               = var.instance_type
  subnet_id                   = var.first_subnet
  vpc_security_group_ids      = var.first_sg
  associate_public_ip_address = true
  key_name                    = aws_key_pair.dz_keypair_1.key_name
  tags = {
    Name = "david_aws_instance_private"
  }
}

# Define an AWS instance in the first VPC public subnet
resource "aws_instance" "first_instance_public" {
  provider                    = aws.first
  ami                         = var.first_ami
  instance_type               = var.instance_type
  subnet_id                   = var.first_subnet_public
  vpc_security_group_ids      = var.first_sg
  associate_public_ip_address = true
  key_name                    = aws_key_pair.dz_keypair_1.key_name
  tags = {
    Name = "david_aws_instance_public"
  }
}

# Define an AWS instance in the second VPC private subnet
resource "aws_instance" "second_instance_private" {
  provider                    = aws.second
  ami                         = var.sec_ami
  instance_type               = var.instance_type
  subnet_id                   = var.second_subnet
  vpc_security_group_ids      = var.second_sg
  key_name                    = aws_key_pair.dz_keypair_2.key_name
  associate_public_ip_address = true
  tags = {
    Name = "david_aws_instance_private"
  }
}

# Define an AWS key pair for the first provider
resource "aws_key_pair" "dz_keypair_1" {
  provider   = aws.first
  key_name   = var.creator_key_pair
  public_key = file(var.keypair_file)
  tags = {
    creator = "David"
  }
}

# Define an AWS key pair for the second provider
resource "aws_key_pair" "dz_keypair_2" {
  provider   = aws.second
  key_name   = var.creator_key_pair
  public_key = file(var.keypair_file)
  tags = {
    creator = "David"
  }
}
