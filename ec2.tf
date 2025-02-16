# Generate SSH private key
resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the private key locally
resource "local_file" "private_key" {
  content         = tls_private_key.bastion.private_key_pem
  filename        = "${path.module}/ec2-key.pem"
  file_permission = "0600"
}

# Import the public key to AWS
resource "aws_key_pair" "bastion" {
  key_name   = "bastion-key"
  public_key = tls_private_key.bastion.public_key_openssh
}

# Create Bastion Host
resource "aws_instance" "bastion" {
  ami                    = "ami-055e3d4f0bbeb5878" # Depending on your region it might change.
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.bastion.key_name
  vpc_security_group_ids = [aws_security_group.bastion.id]

  subnet_id = module.vpc.public_subnet_ids[0]

  associate_public_ip_address = true

  tags = {
    Name = "BastionHost"
  }
}

