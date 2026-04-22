variable "vpc_id" {
  description = "VPC Id"
}

variable "peer_vpc_id" {
  description = "Peer VPC Id"
}

variable "auto_accept" {
  description = "Auto Accept"
  type        = bool
  default     = false
}

variable "route_table_id" {
  description = "Route Table Id"
  type        = map(string)
}

variable "destination_cidr_block" {
  description = "Destination CIDR Block"
  type        = map(string)
}

