resource "aws_route_table" "public_route_table" {
  count  = var.create_public_route_table ? 1 : 0
  vpc_id = var.vpc_id
  tags = merge(
    var.tags,
    {
      Name            = "${var.table_name}"
      Deployment_mode = "Terraform"
    }
  )
}

resource "aws_route" "public_route" {
  count                  = var.create_public_route ? 1 : 0
  route_table_id         = aws_route_table.public_route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_gateway_id
}

resource "aws_route_table_association" "public_association" {
  count = var.create_public_subnet_association ? length(var.subnet_ids) : 0

  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.public_route_table[0].id
}


