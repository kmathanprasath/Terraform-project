variable "vpc_id" {
  description = "vpc id need to be specified"
}

variable "route_table_ids" {
  description = "what are the route table is used for adding vpce route"
  type        = list(string)
}

variable "private_bucket_name" {
  description = "Name of the private bucket"
}

variable "public_bucket_name" {
  description = "Name of the public bucket"
}

variable "region" {
  description = "region which bucket going to create"
}

variable "tags" {
  description = "Maintain by Terraform"
  type        = map(string)
}
