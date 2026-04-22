resource "aws_eip" "nat_eip" {
  # explicit dependency on IGW 
  count = var.create_nat_eip ? 1 : 0
  tags  = var.tags
  #domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  #connectivity_type = public or private default -> public
  count         = var.create_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat_eip[0].id # elastic ip address for NAT
  subnet_id     = var.nat_gateway_subnet_name
  tags = merge(
    var.tags,
    {
      Name            = "${var.network_name}_nat"
      Deployment_mode = "Terraform"
    }
  )
}



resource "aws_internet_gateway" "public_igw" {
  count  = var.create_igw ? 1 : 0
  vpc_id = var.vpc_id
  tags = merge(
    var.tags,
    {
      Name            = "${var.network_name}_igw"
      Deployment_mode = "Terraform"
    }
  )
}