terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0" # version locking is important
    }
  }
}

provider "aws" {
  region = "us-east-1"
}