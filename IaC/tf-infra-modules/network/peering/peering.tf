resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = var.vpc_id
  peer_vpc_id = var.peer_vpc_id
  auto_accept = var.auto_accept

  tags = {
    Name            = "vpc-peering-${var.vpc_id}-${var.peer_vpc_id}"
    Deployment_mode = "Terraform"
  }
}

resource "aws_route" "peer_route_network" {
  for_each                  = var.route_table_id
  route_table_id            = var.route_table_id[each.key]
  destination_cidr_block    = var.destination_cidr_block[each.key]
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}


