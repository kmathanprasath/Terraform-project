output "subnet_id" {
  description = "Subnet Id"
  value       = aws_subnet.subnet.id
}

output "cidr_block" {
  description = "subnet CIDR Block"
  value       = aws_subnet.subnet.cidr_block
}
