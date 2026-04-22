variable "nlb_name" {
  description = "Load Balancer name"
  type        = string
}

variable "internal" {
  description = "Internal or External"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross zone load balancing"
  type        = bool
}
variable "subnet_ids" {
  description = "subnet Ids"
  type        = list(string)
}

variable "target_group_name" {
  description = "Target group Name"
  type        = string
}

variable "load_balancer_type" {
  description = "Load balancer Type"
  type        = string
}
variable "target_ids" {
  description = "Target Ids"
  type        = list(string)
}
variable "target_group_port" {
  description = "Target Group Port"
  type        = number
}

variable "vpc_id" {
  description = "VPC Id"
  type        = string
}


variable "listener_port" {
  description = "Listener Port"
  type        = number
}
