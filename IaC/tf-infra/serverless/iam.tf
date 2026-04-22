module "iam_role" {
  source             = "../../tf-infra-modules/serverless/iam-role"
  iam_role_name      = "LambdaFunctionsExecutionRole"
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id_network_b
  rds_security_group = data.terraform_remote_state.rds.outputs.db_security_group_id
}