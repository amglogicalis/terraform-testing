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