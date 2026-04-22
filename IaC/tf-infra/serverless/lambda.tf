module "get_students" {
  depends_on    = [module.iam_role, module.api_gateway]
  source        = "../../tf-infra-modules/serverless/lambda"
  function_name = "get_students"
  handler       = "bootstrap"
  runtime       = "provided.al2"
  s3_bucket     = "terraform-project-lambda-functions"
  s3_key        = "get_students.zip"
  vpc_subnet_ids = [data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[1],
  data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[2]]
  api_resource_id    = module.api_gateway.students_resource_id
  http_method        = "GET"
  lambda_permissions = "AllowAPIGatewayInvokeGet"
  source_arn         = "${module.api_gateway.execution_arn}/*/GET/students"
  rest_api_id        = module.api_gateway.api_id
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id_network_b
  security_group_ids = [module.iam_role.lambda_security_group,
  data.terraform_remote_state.rds.outputs.db_security_group_id]
  role        = module.iam_role.lamda_role_arn
  stage_name  = "prod"
  db_username = data.terraform_remote_state.rds.outputs.db_username
  db_password = data.terraform_remote_state.rds.outputs.db_password
  db_host     = data.terraform_remote_state.rds.outputs.db_address
  db_port     = data.terraform_remote_state.rds.outputs.db_port
  db_name     = data.terraform_remote_state.rds.outputs.db_name
}

module "post_students" {
  depends_on    = [module.iam_role, module.api_gateway]
  source        = "../../tf-infra-modules/serverless/lambda"
  function_name = "post_students"
  handler       = "bootstrap"
  runtime       = "provided.al2"
  s3_bucket     = "terraform-project-lambda-functions"
  s3_key        = "post_students.zip"
  vpc_subnet_ids = [data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[1],
  data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[2]]
  api_resource_id    = module.api_gateway.students_resource_id
  http_method        = "POST"
  lambda_permissions = "AllowAPIGatewayInvokePost"
  source_arn         = "${module.api_gateway.execution_arn}/*/POST/students"
  rest_api_id        = module.api_gateway.api_id
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id_network_b
  security_group_ids = [module.iam_role.lambda_security_group,
  data.terraform_remote_state.rds.outputs.db_security_group_id]
  role        = module.iam_role.lamda_role_arn
  stage_name  = "prod"
  db_username = data.terraform_remote_state.rds.outputs.db_username
  db_password = data.terraform_remote_state.rds.outputs.db_password
  db_host     = data.terraform_remote_state.rds.outputs.db_address
  db_port     = data.terraform_remote_state.rds.outputs.db_port
  db_name     = data.terraform_remote_state.rds.outputs.db_name

}

module "put_students" {
  depends_on    = [module.iam_role, module.api_gateway]
  source        = "../../tf-infra-modules/serverless/lambda"
  function_name = "put_students"
  handler       = "bootstrap"
  runtime       = "provided.al2"
  s3_bucket     = "terraform-project-lambda-functions"
  s3_key        = "put_students.zip"
  vpc_subnet_ids = [data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[1],
  data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[2]]
  api_resource_id    = module.api_gateway.student_with_id_resource_id
  http_method        = "PUT"
  lambda_permissions = "AllowAPIGatewayInvokePut"
  source_arn         = "${module.api_gateway.execution_arn}/*/PUT/students/{roll_no}"
  rest_api_id        = module.api_gateway.api_id
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id_network_b
  security_group_ids = [module.iam_role.lambda_security_group,
  data.terraform_remote_state.rds.outputs.db_security_group_id]
  role        = module.iam_role.lamda_role_arn
  stage_name  = "prod"
  db_username = data.terraform_remote_state.rds.outputs.db_username
  db_password = data.terraform_remote_state.rds.outputs.db_password
  db_host     = data.terraform_remote_state.rds.outputs.db_address
  db_port     = data.terraform_remote_state.rds.outputs.db_port
  db_name     = data.terraform_remote_state.rds.outputs.db_name
}

module "delete_students" {
  depends_on    = [module.iam_role, module.api_gateway]
  source        = "../../tf-infra-modules/serverless/lambda"
  function_name = "delete_students"
  handler       = "bootstrap"
  runtime       = "provided.al2"
  s3_bucket     = "terraform-project-lambda-functions"
  s3_key        = "delete_students.zip"
  vpc_subnet_ids = [data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[1],
  data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[2]]
  api_resource_id    = module.api_gateway.student_with_id_resource_id
  http_method        = "DELETE"
  lambda_permissions = "AllowAPIGatewayInvokeDelete"
  source_arn         = "${module.api_gateway.execution_arn}/*/DELETE/students/{roll_no}"
  rest_api_id        = module.api_gateway.api_id
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id_network_b
  security_group_ids = [module.iam_role.lambda_security_group, data.terraform_remote_state.rds.outputs.db_security_group_id]
  role               = module.iam_role.lamda_role_arn
  stage_name         = "prod"
  db_username        = data.terraform_remote_state.rds.outputs.db_username
  db_password        = data.terraform_remote_state.rds.outputs.db_password
  db_host            = data.terraform_remote_state.rds.outputs.db_address
  db_port            = data.terraform_remote_state.rds.outputs.db_port
  db_name            = data.terraform_remote_state.rds.outputs.db_name
}

