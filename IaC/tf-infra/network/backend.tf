terraform {
  backend "s3" {
    bucket         = "terraform-project-state-file"
    key            = "terraform/network/network.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-project-state-file"
  }
}