variable "db_name" {
  description = "database Name"
  type        = string
}

variable "identifier" {
  description = "Indentifier"
  type        = string
}

variable "engine" {
  description = "database engine"
  type        = string
}

variable "allocated_storage" {
  description = "allocated storage"
  type        = number
}

variable "engine_version" {
  description = "database engine version"
  type        = string
}

variable "instance_class" {
  description = "database Instance Class"
  type        = string
}

variable "username" {
  description = "database username"
  type        = string
}

variable "password_length" {
  description = "database Password Length"
  type        = number
}

variable "publicly_accessible" {
  description = "Publicly Accessible"
  type        = bool
}


variable "subnet_ids" {
  description = "subnet Ids"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "subnet group name"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
}

variable "secret_db_name" {
  description = "DB Credentials"
}

variable "secret_recovery_days" {
  description = "secret recovery days"
  type        = number
}

variable "create_sg" {
  description = "create security group"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC Id"
}

variable "enable_db_access_app_1" {
  description = "Vm-app-1"
  type        = bool
}

variable "vm_app_1_private_ip" {
  description = "vm-app-1-private-IP"
}

variable "vm_app_2_private_ip" {
  description = "Vm-app-2-private-IP"
}

variable "enable_db_access_app_2" {
  description = "Enable for vm-app-2"
  type        = bool
}

variable "enable_lambda_sg" {
  description = "Lambda security Group"
  type        = bool
}

variable "lambda_security_group" {
  description = "lambda security Group Id"
  default     = ""
}