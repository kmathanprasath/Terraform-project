variable "vpc_id" {
  description = "VPC Id"
}

variable "tags" {
  description = "Maintain By terraform"
  type        = map(string)
}

variable "network_name" {
  description = "Network Name"
}

variable "create_igw" {
  description = "IGW description"
  type        = bool
  default     = true
}

variable "create_nat_eip" {
  description = "Create NAT"
  type        = bool
  default     = false
}

variable "create_nat_gateway" {
  description = "Create NAT Gateway"
  type        = bool
  default     = true
}

variable "nat_gateway_subnet_name" {
  description = "NAT Gateway subnet Name"
}



