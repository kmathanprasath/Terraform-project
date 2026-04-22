variable "create_public_route_table" {
  description = "Whether To Create public route table"
  type        = bool
  default     = true
}

variable "table_name" {
  description = "Table Name"
}

variable "create_public_route" {
  description = "Create Public Route"
  type        = bool
  default     = true
}

variable "create_public_subnet_association" {
  description = "Create Public subnet association"
  type        = bool
}

variable "associate_public_subnets" {
  description = "associate public subnets"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "VPC Id"
}

variable "igw_gateway_id" {
  description = "Internet Gateway Id"
}


variable "subnet_ids" {
  description = "Subnet Id"
  type        = list(string)
}



variable "tags" {
  description = "Maintain by Terraform"
  type        = map(string)
}