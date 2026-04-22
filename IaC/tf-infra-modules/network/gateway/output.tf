output "internet_gateway_id" {
  description = "Internet gateway ID"
  value       = aws_internet_gateway.public_igw[0].id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = length(aws_nat_gateway.nat_gateway) > 0 ? aws_nat_gateway.nat_gateway[0].id : null
}