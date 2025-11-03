output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.main.id
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.main.arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_port" {
  description = "The port the RDS instance listens on"
  value       = aws_db_instance.main.port
}

output "db_instance_username" {
  description = "The master username for the RDS instance"
  value       = aws_db_instance.main.username
  sensitive   = true
}

output "db_instance_database_name" {
  description = "The name of the database"
  value       = aws_db_instance.main.name
}

output "db_security_group_id" {
  description = "The ID of the security group attached to the RDS instance"
  value       = aws_security_group.rds.id
}

output "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  value       = aws_db_subnet_group.main.name
}

output "db_parameter_group_name" {
  description = "The name of the DB parameter group"
  value       = aws_db_parameter_group.main.name
}
