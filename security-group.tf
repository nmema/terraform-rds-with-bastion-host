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

resource "aws_security_group" "rds" {
  name        = "RDSMariaDBSG"
  description = "Allow access to RDS MariaDB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "MariaDB/Aurora MySQL"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }
}
