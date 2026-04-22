output "db_name" {
  description = "Database Name"
  value       = module.project_db.db_name
}

output "db_address" {
  description = "Database Address"
  value       = module.project_db.db_address
}

output "db_security_group_id" {
  description = "Database Security Group Id"
  value       = module.project_db.db_security_group
}

output "db_password" {
  description = "Database Password"
  value       = module.project_db.db_password
  sensitive   = true
}

output "db_username" {
  description = "Database Username"
  value       = module.project_db.db_username
}

output "db_port" {
  description = "Database Port"
  value       = module.project_db.db_port
}