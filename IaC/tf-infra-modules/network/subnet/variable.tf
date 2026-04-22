variable "vpc_id" {
  description = "VPC Id"
}

variable "cidr_block" {
  description = "Cidr Block"
}

variable "availability_zone" {
  description = "Availability Zone"
}

variable "map_public_ip_on_launch" {
  description = "Map Public IP on Launch information"
  type        = bool
}

variable "tags" {
  description = "Maintained By Terraform"
  type        = map(string)
}

variable "subnet_name" {
  description = "Subnet name"
}



