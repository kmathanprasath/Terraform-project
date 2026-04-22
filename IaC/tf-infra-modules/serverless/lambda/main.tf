resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = var.role
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key

  environment {
    variables = {
      DB_USER     = var.db_username
      DB_HOST     = var.db_host
      DB_PORT     = var.db_port
      DB_PASSWORD = var.db_password
      DB_NAME     = var.db_name
    }
  }

  vpc_config {
    subnet_ids         = var.vpc_subnet_ids
    security_group_ids = var.security_group_ids
  }
}


resource "aws_api_gateway_method" "api_method" {
  rest_api_id   = var.rest_api_id     # api gateway id
  resource_id   = var.api_resource_id # particular resource endpoint id
  http_method   = var.http_method     # kind of http method
  authorization = "NONE"              # no token validation needed
}


resource "aws_api_gateway_integration" "api_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = var.api_resource_id
  http_method             = aws_api_gateway_method.api_method.http_method
  integration_http_method = "POST"                                         # method used to invoke the lambda function
  type                    = "AWS_PROXY"                                    # API gateway will automatically convert the incoming http request into a format suitable for Lambda and convert the Lambda response back into an HTTP response.
  uri                     = aws_lambda_function.lambda_function.invoke_arn #arn of lambda function will be invoked when this integration is triggered.
}


resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = var.lambda_permissions
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com" # which aws service is going to use this lambda
  source_arn    = var.source_arn             # gateway arn with endpoint
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.api_integration # deployement with api-gateway
  ]
  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name # stage name
}
