# Put subnets in a Subnet Group
resource "aws_db_subnet_group" "mariadb" {
  name       = "rds-subnet-group"
  subnet_ids = module.vpc.private_subnet_ids

  tags = {
    Name = "RDSSubnetGroup"
  }
}

# Create DB instance
resource "aws_db_instance" "mariadb" {
  identifier             = "tutorial-instance"
  allocated_storage      = 10
  db_name                = "tutorial"
  engine                 = "mariadb"
  engine_version         = "11.4.4"
  instance_class         = "db.t3.micro"
  username               = var.master_username
  password               = var.master_password
  db_subnet_group_name   = aws_db_subnet_group.mariadb.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true

  tags = {
    Name = "MariaDBInstance"
  }
}
