resource "aws_route_table" "private_route_table" {
  #Creating route table
  count  = var.create_private_route_table ? 1 : 0
  vpc_id = var.vpc_id
  tags = merge(
    var.tags,
    {
      Name            = "${var.network_name}_private"
      Deployment_mode = "Terraform"
    }
  )
}

resource "aws_route" "private_route" {
  # creating nat route
  count                  = var.create_private_route ? 1 : 0
  route_table_id         = aws_route_table.private_route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id
}

resource "aws_route_table_association" "private_association" {
  #Associating route table to subnets
  count          = var.create_private_subnet_association ? length(var.subnet_ids) : 0
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.private_route_table[0].id

}
