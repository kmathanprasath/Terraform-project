output "api_id" {
  description = "API gateway ID"
  value       = aws_api_gateway_rest_api.api_gateway.id
}

output "root_resource_id" {
  description = "Root Resource ID"
  value       = aws_api_gateway_rest_api.api_gateway.root_resource_id
}

output "students_resource_id" {
  description = "Student Resource Id"
  value       = aws_api_gateway_resource.main_id.id
}

output "student_with_id_resource_id" {
  description = "Student will Rollno Resource Id"
  value       = aws_api_gateway_resource.resource_with_id.id
}

output "execution_arn" {
  description = "Execution ARN for mapping source ARN in Lambda functions"
  value       = aws_api_gateway_rest_api.api_gateway.execution_arn
}