data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "terraform-project-state-file"
    key    = "terraform/network/network.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "rds" {
  backend = "s3"

  config = {
    bucket = "terraform-project-state-file"
    key    = "terraform/database/database.tfstate"
    region = "us-east-1"
  }
}

