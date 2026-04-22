output "db_name" {
  description = "Database Name"
  value       = aws_db_instance.db.db_name
}

output "db_endpoint" {
  description = "Database Endpoint"
  value       = aws_db_instance.db.endpoint
}

output "db_address" {
  description = "Database Address"
  value       = aws_db_instance.db.address
}

output "db_password" {
  description = "Database Password"
  value       = random_password.db_password.result
  sensitive   = true
}

output "db_username" {
  description = "Database Username"
  value       = aws_db_instance.db.username
}

output "db_port" {
  description = "Database Port"
  value       = aws_db_instance.db.port
}

output "db_security_group" {
  description = "Database Security Group"
  value       = var.create_sg ? aws_security_group.db_sg[0].id : null
}