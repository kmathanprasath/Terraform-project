output "private_route_table_id" {
  description = "Private Route Table"
  value       = aws_route_table.private_route_table[0].id
}

output "private_route_table_association_ids" {
  description = "Private Route Table Association Id"
  value = [
    for assoc in aws_route_table_association.private_association : assoc.id
  ]
}

output "private_subnet_ids" {
  description = "Private Subnet Ids"
  value       = var.subnet_ids
}
