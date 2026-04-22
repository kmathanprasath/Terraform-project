output "private_s3_bucket_name" {
  description = "output of private s3 bucket name"
  value       = aws_s3_bucket.private_bucket.bucket
}

output "public_s3_bucket_name" {
  description = "output of public s3 bucket name"
  value       = aws_s3_bucket.public_bucket.bucket
}

output "s3_vpc_endpoint_id" {
  description = "vpc Endpoint ID"
  value       = aws_vpc_endpoint.s3_vpc_endpoint.id
}
