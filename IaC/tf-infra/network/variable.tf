######Network-A#########
variable "subnet_network_a" {
  description = "subnet defining for network_a"
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    subnet_name             = string
    tags                    = map(string)
  }))

  default = {
    "subnet_a" = {
      cidr_block              = "10.0.1.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
      subnet_name             = "subnet_a"
      tags = {
        Name            = "subnet_a"
        Deployment_mode = "Terraform"
      }
    }
    "subnet_b" = {
      cidr_block              = "10.0.2.0/24"
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = false
      subnet_name             = "subnet_b"
      tags = {
        Name            = "subnet_b"
        Deployment_mode = "Terraform"
      }
    }
  }
}

######Network-B#########
variable "subnet_network_b" {
  description = "Defining subnet for network_b"
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    subnet_name             = string
    tags                    = map(string)
  }))

  default = {
    "subnet_bastion" = {
      cidr_block              = "10.1.1.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
      subnet_name             = "subnet_bastion"
      tags = {
        Name            = "subnet_bastion"
        Deployment_mode = "Terraform"
      }
    }
    "subnet_c" = {
      cidr_block              = "10.1.2.0/24"
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = false
      subnet_name             = "subnet_c"
      tags = {
        Name            = "subnet_c"
        Deployment_mode = "Terraform"
      }
    }
    "subnet_d" = {
      cidr_block              = "10.1.3.0/24"
      availability_zone       = "us-east-1c"
      map_public_ip_on_launch = false
      subnet_name             = "subnet_d"
      tags = {
        Name            = "subnet_d"
        Deployment_mode = "Terraform"
      }
    }
    "subnet_e" = {
      cidr_block              = "10.1.4.0/24"
      availability_zone       = "us-east-1d"
      map_public_ip_on_launch = false
      subnet_name             = "subnet_e"
      tags = {
        Name            = "subnet_e"
        Deployment_mode = "Terraform"
      }
    }
  }
}
