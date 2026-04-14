module "dynamodb" {
  source = "./modules/dynamodb"
  name   = "demo"
}

module "lambda" {
  source = "./modules/lambda"

  name                = "demo"
  lambda_zip          = "lambda.zip"
  dynamodb_table_name = module.dynamodb.table_name
}

module "api_gateway" {
  source = "./modules/api_gateway"

  name              = "demo"
  lambda_invoke_arn = module.lambda.invoke_arn
}

resource "aws_lambda_permission" "apigw" {
  statement_id = "AllowExecutionFromAPIGateway"
  action       = "lambda:InvokeFunction"

  function_name = module.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${module.api_gateway.execution_arn}/*/*"
}