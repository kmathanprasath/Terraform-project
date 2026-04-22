output "ec2_id" {
  description = "Instance ID"
  value       = aws_instance.ec2.id
}

output "public_ip" {
  description = "Instance Public IP"
  value       = aws_instance.ec2.public_ip
}

output "private_ip" {
  description = "Instance Private IP"
  value       = aws_instance.ec2.private_ip
}

output "vm_key" {
  description = "Instance Key"
  value       = tls_private_key.key.private_key_pem
}

output "role_name" {
  description = "Instance Role"
  value       = var.create_ec2_role ? aws_iam_instance_profile.ec2_instance_profile[0].name : null
}