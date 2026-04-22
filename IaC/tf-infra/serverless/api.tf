module "api_gateway" {
  source           = "../../tf-infra-modules/serverless/api-gateway"
  api_name         = "StudentAPI"
  main_resource_id = "students"
  sub_resource_id  = "{roll_no}"
}