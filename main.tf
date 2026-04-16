module "dynamodb" {
  source = "./modules/dynamodb"
  name   = var.project_name
}

module "lambda" {
  source = "./modules/lambda"

  name                = var.project_name
  lambda_zip          = "${path.module}/modules/lambda/lambda.zip"
  dynamodb_table_name = module.dynamodb.table_name
  role_arn            = var.role_arn
  bucket_name         = module.s3.bucket_name
}

module "api_gateway" {
  source = "./modules/api_gateway"

  name              = var.project_name
  lambda_invoke_arn = module.lambda.invoke_arn
}

resource "aws_lambda_permission" "apigw" {
  statement_id = "AllowExecutionFromAPIGateway"
  action       = "lambda:InvokeFunction"

  function_name = module.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${module.api_gateway.execution_arn}/*/*"
}

module "s3" {
  source = "./modules/s3"
  name   = var.project_name
}
