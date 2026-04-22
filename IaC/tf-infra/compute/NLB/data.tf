data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "terraform-project-state-file"
    key    = "terraform/network/network.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "ec2" {
  backend = "s3"

  config = {
    bucket = "terraform-project-state-file"
    key    = "terraform/compute/compute.tfstate"
    region = "us-east-1"
  }
}
