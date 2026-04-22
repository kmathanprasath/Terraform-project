module "vpc_network_b" {
  source         = "../../tf-infra-modules/network/vpc"
  vpc_cidr_block = "10.1.0.0/16"
  tags = {
    Name            = "network_b"
    Deployment_mode = "Terraform"
  }

}

module "network_b_subnet" {
  source   = "../../tf-infra-modules/network/subnet"
  for_each = var.subnet_network_b

  vpc_id                  = module.vpc_network_b.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  subnet_name             = each.value.subnet_name
  tags                    = each.value.tags
}

module "network_b_gateway" {
  source = "../../tf-infra-modules/network/gateway"

  vpc_id                  = module.vpc_network_b.vpc_id
  create_igw              = true
  nat_gateway_subnet_name = module.network_b_subnet.subnet_bastion.subnet_id
  create_nat_gateway      = true
  create_nat_eip          = true
  network_name            = "network_b"
  tags = {
    Name            = "network_b_gateway"
    Deployment_mode = "Terraform"
  }
}

module "network_b_public_route_table" {
  depends_on = [module.network_b_gateway]
  source     = "../../tf-infra-modules/network/route-table/public-route-table"

  create_public_route_table        = true
  vpc_id                           = module.vpc_network_b.vpc_id
  create_public_route              = true
  igw_gateway_id                   = module.network_b_gateway.internet_gateway_id
  create_public_subnet_association = true
  associate_public_subnets         = true
  table_name                       = "network_b_public"
  subnet_ids                       = [module.network_b_subnet.subnet_bastion.subnet_id]
  tags = {
    Name            = "network_b_public_table"
    Deployment_mode = "Terraform"
  }
}


module "network_b_private_route_table" {
  depends_on = [module.network_b_gateway]
  source     = "../../tf-infra-modules/network/route-table/private-route-table"

  vpc_id                            = module.vpc_network_b.vpc_id
  associate_private_subnets         = true
  create_private_route              = true
  nat_gateway_id                    = module.network_b_gateway.nat_gateway_id
  create_private_route_table        = true
  create_private_subnet_association = true
  network_name                      = "network_b"
  subnet_ids                        = [module.network_b_subnet.subnet_c.subnet_id]
  tags = {
    Name            = "network_b_private_table"
    Deployment_mode = "Terraform"
  }
}

module "database_route_table_network_b" {
  source                           = "../../tf-infra-modules/network/route-table/public-route-table"
  table_name                       = "database_route_table"
  associate_public_subnets         = false
  create_public_route              = false
  create_public_route_table        = true
  create_public_subnet_association = true
  igw_gateway_id                   = module.network_b_gateway.internet_gateway_id
  vpc_id                           = module.vpc_network_b.vpc_id
  subnet_ids = [module.network_b_subnet.subnet_d.subnet_id,
  module.network_b_subnet.subnet_e.subnet_id]
  tags = {
    Name            = "network_b_database_table"
    Deployment_mode = "Terraform"
  }
}