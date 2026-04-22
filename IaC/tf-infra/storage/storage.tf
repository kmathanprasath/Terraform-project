module "s3_bucket" {
  source = "../../tf-infra-modules/storage"

  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id_network_b
  route_table_ids     = [data.terraform_remote_state.vpc.outputs.network_b_private_route_table]
  private_bucket_name = "project-storage-open-access"
  public_bucket_name  = "project-storage-network-access"
  region              = "us-east-1"

  tags = {
    Name            = "project-S3-Buckets"
    Deployment_mode = "Terraform"
  }
}


