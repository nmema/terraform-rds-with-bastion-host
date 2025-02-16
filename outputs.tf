output "bastion_public_ip" {
  description = "Public IP of the Bastion Host"
  value       = aws_instance.bastion.public_ip
}

output "rds_endpoint" {
  description = "Endpoint to connect MariaDB instance"
  value       = aws_db_instance.mariadb.endpoint
}
