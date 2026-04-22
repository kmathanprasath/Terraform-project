
output "invoke_url" {
  description = "Invoke URL for Public Accessing the Lambda functions"
  value       = module.get_students.api_gateway_url
}

output "lambda_security_group" {
  description = "The security Group for Connecting Database"
  value       = module.iam_role.lambda_security_group
}