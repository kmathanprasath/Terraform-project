
variable "create_private_route_table" {
  description = "Create private route Table"
  type        = bool
  default     = true
}

variable "create_private_route" {
  description = "Create private route"
  type        = bool
  default     = true
}

variable "associate_private_subnets" {
  description = "associate private subnets"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "VPC Id"
}

variable "create_private_subnet_association" {
  description = "create private subnet association"
  type        = bool
}

variable "tags" {
  description = "Maintain By Terraform"
  type        = map(string)
}

variable "network_name" {
  description = "Network Name"
}

variable "nat_gateway_id" {
  description = "NAT gateway Id"
  type        = string
  default     = ""
}
variable "subnet_ids" {
  description = "Subnet Id"
  type        = list(string)
}

