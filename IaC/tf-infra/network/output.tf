output "vpc_id_network_a" {
  description = "VPC Id for network_a"
  value       = module.vpc_network_a.vpc_id
}

output "vpc_cidr_block_network_a" {
  description = "VPC CIDR block of network_a"
  value       = module.vpc_network_a.vpc_cidr_block
}

output "network_a_public_subnet_ids" {
  description = "public subnet Id in network_a"
  value = [
    module.network_a_subnet.subnet_a.subnet_id
  ]
}

output "network_a_public_cidr_blocks" {
  description = "public subnet CIDR block of network_a"
  value = [
    module.network_a_subnet.subnet_a.cidr_block
  ]
}

output "network_a_private_subnet_ids" {
  description = "private subnet id of network_a"
  value = [
    module.network_a_subnet.subnet_b.subnet_id
  ]
}

output "network_a_private_cidr_blocks" {
  description = "private subnet CIDR block of network_a"
  value = [
    module.network_a_subnet.subnet_b.cidr_block
  ]
}

output "network_a_internet_gateway" {
  description = "Internet gateway id of network_a"
  value       = module.network_a_gateway.internet_gateway_id
}

output "network_a_public_route_table" {
  description = "public route table id of network_a"
  value       = module.network_a_public_route_table.public_route_table_id
}

output "network_a_public_route_association" {
  description = "public route table association id"
  value       = module.network_a_public_route_table.public_route_table_association_ids
}


output "network_a_private_route_table" {
  description = "private route table id of network_a"
  value       = module.network_a_private_route_table.private_route_table_id
}

output "network_a_private_table_association" {
  description = "private route table association of network_a"
  value       = module.network_a_private_route_table.private_route_table_association_ids
}

# //---------------------------------------------------------------

output "vpc_id_network_b" {
  description = "VPC id of network_b"
  value       = module.vpc_network_b.vpc_id
}

output "vpc_cidr_block_network_b" {
  description = "VPC CIDR block of network_b"
  value       = module.vpc_network_b.vpc_cidr_block
}

output "network_b_public_subnet_ids" {
  description = "Public subnet id of network_b"
  value = [
    module.network_b_subnet.subnet_bastion.subnet_id
  ]
}

output "network_b_public_cidr_blocks" {
  description = "pulic subnet cidr block of network_b"
  value = [
    module.network_b_subnet.subnet_bastion.cidr_block
  ]
}

output "network_b_private_subnet_ids" {
  description = "private subnet id of network_b"
  value = [

    module.network_b_subnet.subnet_c.subnet_id,
    module.network_b_subnet.subnet_d.subnet_id,
    module.network_b_subnet.subnet_e.subnet_id
  ]
}

output "network_b_private_cidr_blocks" {
  description = "private subnet cidr block of network_b"
  value = [

    module.network_b_subnet.subnet_c.cidr_block,
    module.network_b_subnet.subnet_d.cidr_block,
    module.network_b_subnet.subnet_e.cidr_block
  ]
}

output "network_b_internet_gateway" {
  description = "Internet Gateway of network_b"
  value       = module.network_b_gateway.internet_gateway_id
}

output "network_b_public_route_table" {
  description = "public route table of network_b"
  value       = module.network_b_public_route_table.public_route_table_id
}

output "network_b_public_route_association" {
  description = "public route table association id of network_b"
  value       = module.network_b_public_route_table.public_route_table_association_ids
}

output "network_b_nat_gateway" {
  description = "NAT Gateway id of network_b"
  value       = module.network_b_gateway.nat_gateway_id
}

output "network_b_private_route_table" {
  description = "Private route table id of network_b"
  value       = module.network_b_private_route_table.private_route_table_id
}

output "network_b_private_table_association" {
  description = "private route tabla association id of network_b"
  value       = module.network_b_private_route_table.private_route_table_association_ids
}



#-------------------------------------------------------------------------------------------

output "vpc_peering_connection_id" {
  description = "vpc peering connection id"
  value       = module.vpc_peering.vpc_peering_connection_id
}

