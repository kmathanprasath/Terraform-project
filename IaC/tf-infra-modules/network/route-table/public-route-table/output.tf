output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.public_route_table[0].id
}

output "public_route_table_association_ids" {
  description = "Public Route Table Association ID"
  value = [
    for assoc in aws_route_table_association.public_association : assoc.id
  ]
}
