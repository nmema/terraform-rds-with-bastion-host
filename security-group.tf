data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

resource "aws_security_group" "bastion" {
  name        = "BastionHostSG"
  description = "Allow SSH access to the bastion host"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
