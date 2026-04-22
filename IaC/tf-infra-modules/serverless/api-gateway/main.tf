resource "aws_api_gateway_rest_api" "api_gateway" {
  name = var.api_name
  endpoint_configuration {
    types = ["REGIONAL"] #default= EDGE
  }
}


resource "aws_api_gateway_resource" "main_id" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = var.main_resource_id
}

# API Gateway Resource for students/{roll_no}
resource "aws_api_gateway_resource" "resource_with_id" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.main_id.id
  path_part   = var.sub_resource_id
}

