module "vpc_network_a" {
  source         = "../../tf-infra-modules/network/vpc"
  vpc_cidr_block = "10.0.0.0/16"
  tags = {
    Name            = "network_a"
    Deployment_mode = "Terraform"
  }

}

module "network_a_subnet" {
  source                  = "../../tf-infra-modules/network/subnet"
  for_each                = var.subnet_network_a
  vpc_id                  = module.vpc_network_a.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  subnet_name             = each.value.subnet_name
  tags                    = each.value.tags
}

module "network_a_gateway" {
  source                  = "../../tf-infra-modules/network/gateway"
  vpc_id                  = module.vpc_network_a.vpc_id
  create_igw              = true
  network_name            = "network_a"
  create_nat_gateway      = false
  create_nat_eip          = false
  nat_gateway_subnet_name = module.network_a_subnet.subnet_a.subnet_id
  tags = {
    Name            = "network_a_gateway"
    Deployment_mode = "Terraform"
  }
}

module "network_a_public_route_table" {
  depends_on = [module.network_a_gateway]
  source     = "../../tf-infra-modules/network/route-table/public-route-table"

  create_public_route_table        = true
  vpc_id                           = module.vpc_network_a.vpc_id
  create_public_route              = true
  igw_gateway_id                   = module.network_a_gateway.internet_gateway_id
  create_public_subnet_association = true
  associate_public_subnets         = true
  table_name                       = "network_a_public"
  subnet_ids                       = [module.network_a_subnet.subnet_a.subnet_id]
  tags = {
    Name            = "network_a_public_table"
    Deployment_mode = "Terraform"
  }
}

module "network_a_private_route_table" {
  depends_on                        = [module.network_a_gateway]
  source                            = "../../tf-infra-modules/network/route-table/private-route-table"
  vpc_id                            = module.vpc_network_a.vpc_id
  associate_private_subnets         = true
  create_private_route              = false
  nat_gateway_id                    = module.network_a_gateway.nat_gateway_id
  create_private_route_table        = true
  create_private_subnet_association = true
  network_name                      = "network_a"
  subnet_ids                        = [module.network_a_subnet.subnet_b.subnet_id]
  tags = {
    Name            = "network_a_private_table"
    Deployment_mode = "Terraform"
  }
}


