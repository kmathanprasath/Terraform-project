output "private_s3_bucket_name" {
  description = "Private s3 bucket Name"
  value       = module.s3_bucket.private_s3_bucket_name
}

output "public_s3_bucket_name" {
  description = "Public s3 bucket Name"
  value       = module.s3_bucket.public_s3_bucket_name
}

output "s3_vpc_endpoint_id" {
  description = "VPC Endpoint for Private Connection"
  value       = module.s3_bucket.s3_vpc_endpoint_id
}