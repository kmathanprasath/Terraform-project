
variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "ami_id" {
  description = "AMI Id"
  type        = string
}

variable "subnet_id" {
  description = "Subnet Id"
  type        = string
}

variable "tags" {
  description = "Maintain By Terraform"
  type        = map(string)
}

variable "associate_public_ip_address" {
  description = "Associate public ip address"
  type        = bool
}

variable "key_name" {
  description = "Key_Name"
  type        = string
}



variable "use_public_ip" {
  description = "Use Public IP"
  type        = bool
  default     = true
}

variable "enable_user_data" {
  description = "Enable User data"
  type        = bool
  default     = false
}

variable "user_data" {
  description = "user data"
  type        = string
}

variable "enable_file_provisioner" {
  description = "Enable file provisioner"
  type        = bool
  default     = false
}
variable "user_ip" {
  description = "User Ip from Data block"
  default     = ""
}
variable "source_file" {
  description = "source file"
  type        = string
  default     = ""
}

variable "create_sg" {
  description = "Create security group"
  type        = bool
}
variable "vpc_id" {
  description = "VPC Id"
}
variable "file_destination" {
  description = "File Destination"
  type        = string
  default     = ""
}
variable "enable_bastion_ssh" {
  description = "Enable bastion SSH"
  type        = bool
  default     = false
}
variable "enable_nginx_http" {
  description = "Enable Nginx HTTP"
  type        = bool
  default     = false
}
variable "enable_remote_exec" {
  description = "Enable Remote Exec"
  type        = bool
  default     = false
}

variable "remote_exec_commands" {
  description = "Remote Exec"
  type        = list(string)
  default     = []
}

variable "enable_local_exec" {
  description = "Enable Local Exec"
  type        = bool
  default     = false
}

variable "local_exec_commands" {
  description = "Local Exec Commands"
  type        = list(string)
  default     = []
}

variable "bastion_key_content" {
  description = "Bastion Key Content"
  type        = string
  default     = ""
}

variable "bastion_host" {
  description = "Bastion Host"
  type        = string
  default     = ""
}

variable "enable_ssh" {
  description = "Enable SSH"
  type        = bool
  default     = false
}


variable "create_ec2_role" {
  description = "Create EC2 Role"
  type        = bool
}

variable "sg_ssh_cidr" {
  description = "Security Group CIDR"
  default     = ""
}

variable "enable_vpc_peering_sg" {
  description = "Enable VPC Peering Security Group"
  type        = bool
  default     = false
}


variable "enable_default_egress" {
  description = "Enable Default Egress"
  type        = bool
  default     = false
}

variable "app_peer_cidr" {
  description = "App Peer CIDR"
  default     = ""
}
variable "enable_app_http" {
  description = "Enable App HTTP"
  type        = bool
  default     = false
}
variable "enable_app_listen_port" {
  description = "Enable App Listen Port"
  type        = bool
  default     = false
}