# Define an AWS instance in the src VPC private subnet
resource "aws_instance" "src_instance_private" {
  provider                    = aws.src
  ami                         = var.src_ami
  instance_type               = var.instance_type
  subnet_id                   = var.src_subnet
  vpc_security_group_ids      = var.src_sg
  user_data                   = file("modules/scripts/${var.ubuntu_data_file}")
  associate_public_ip_address = true
  key_name                    = aws_key_pair.dz_keypair_1.key_name
  tags = {
    Name = "${var.name}_aws_instance_private"
  }
}

# Define an AWS instance in the src VPC public subnet
resource "aws_instance" "src_instance_public" {
  provider                    = aws.src
  ami                         = var.src_ami
  instance_type               = var.instance_type
  subnet_id                   = var.src_subnet_public
  vpc_security_group_ids      = var.src_sg
  user_data                   = file("modules/scripts/${var.ubuntu_data_file}")
  associate_public_ip_address = true
  key_name                    = aws_key_pair.dz_keypair_1.key_name
  tags = {
    Name = "${var.name}_aws_instance_public"
  }
}

# Define an AWS instance in the dst VPC private subnet
resource "aws_instance" "dst_instance_private" {
  provider                    = aws.dst
  ami                         = var.sec_ami
  instance_type               = var.instance_type
  subnet_id                   = var.dst_subnet
  vpc_security_group_ids      = var.dst_sg
  user_data                   = file("modules/scripts/${var.ubuntu_data_file}")
  key_name                    = aws_key_pair.dz_keypair_2.key_name
  associate_public_ip_address = true
  tags = {
    Name = "${var.name}_aws_instance_private"
  }
}

# Define an AWS key pair for the src provider
resource "aws_key_pair" "dz_keypair_1" {
  provider   = aws.src
  key_name   = "${var.name}-key"
  public_key = file(var.keypair_file)
  tags = {
    creator = "${var.name}"
  }
}

# Define an AWS key pair for the dst provider
resource "aws_key_pair" "dz_keypair_2" {
  provider   = aws.dst
  key_name   = "${var.name}-key"
  public_key = file(var.keypair_file)
  tags = {
    creator = "David"
  }
}


