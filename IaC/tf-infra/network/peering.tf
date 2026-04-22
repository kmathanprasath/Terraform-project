module "vpc_peering" {
  source = "../../tf-infra-modules/network/peering"

  vpc_id      = module.vpc_network_a.vpc_id
  peer_vpc_id = module.vpc_network_b.vpc_id
  auto_accept = true
  route_table_id = {
    "network_a" = module.network_a_private_route_table.private_route_table_id
    "network_b" = module.network_b_private_route_table.private_route_table_id
  }
  destination_cidr_block = {
    "network_a" = module.vpc_network_b.vpc_cidr_block
    "network_b" = module.vpc_network_a.vpc_cidr_block
  }
}
