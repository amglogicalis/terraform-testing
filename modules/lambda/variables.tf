variable "name" {
  type = string
}

variable "lambda_zip" {
  type        = string
  description = "Path to lambda zip file"
}

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name"
}

variable "role_arn" {
  type = string
}

variable "bucket_name" {
  type = string
}
