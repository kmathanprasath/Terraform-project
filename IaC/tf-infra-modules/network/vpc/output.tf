output "vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.vpc_common.id
}

output "vpc_cidr_block" {
  description = "Vpc CIDR Block"
  value       = aws_vpc.vpc_common.cidr_block
}