variable "function_name" {
  description = "Function name"
}
variable "handler" {
  description = "Information about Handler"
}
variable "runtime" {
  description = "Information about runtime"
}
variable "s3_bucket" {
  description = "Bucket Name which consists of lambda functions"
}
variable "s3_key" {
  description = "Lambda function name"
}
variable "vpc_subnet_ids" {
  description = "Subnet ids for database access"
  type        = list(string)
}
variable "api_resource_id" {
  description = "specified API resource id"
}
variable "http_method" {
  description = "http method used"
}
variable "lambda_permissions" {
  description = "Lambda permission"
}
variable "source_arn" {
  description = "API Gateway source arn"
}
variable "rest_api_id" {
  description = "API id "
}
variable "vpc_id" {
  description = "VPC id"
}
variable "security_group_ids" {
  description = "Security Group Id"
  type        = list(string)
}
variable "role" {
  description = "Role"
}
variable "stage_name" {
  description = "Stage Name"
}
variable "db_username" {
  description = "username of Database"
}
variable "db_host" {
  description = "Database HostName"
}
variable "db_name" {
  description = "Database Name"
}
variable "db_password" {
  description = "Database Password"
}
variable "db_port" {
  description = "Database Port"
  type        = number
}