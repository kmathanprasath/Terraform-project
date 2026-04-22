terraform {
  backend "s3" {
    bucket         = "terraform-project-state-file"
    key            = "terraform/compute/compute.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-project-state-file"

  }
}