resource "aws_vpc" "vpc_common" {
  cidr_block = var.vpc_cidr_block
  tags       = var.tags
}
