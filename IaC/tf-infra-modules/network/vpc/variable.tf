variable "vpc_cidr_block" {
  description = "VPC Cidr Block"
}

variable "tags" {
  description = "Tags for Terraform Deployment"
  type        = map(string)
}

