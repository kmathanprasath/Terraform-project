output "lambda_security_group" {
  description = "Lambda security group ID"
  value       = aws_security_group.lambda_sg.id
}

output "lamda_role_arn" {
  description = "Lambda Role ARN"
  value       = aws_iam_role.lambda_exec.arn
}