resource "aws_lambda_function" "this" {
  function_name = "demo-lambda"
  runtime       = "python3.12"
  handler       = "lambda_function.lambda_handler"

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")

  role = "arn:aws:iam::339712980459:role/LabRole"

  timeout     = 3
  memory_size = 128

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }
}