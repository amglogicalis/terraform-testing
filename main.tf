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