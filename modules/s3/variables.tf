variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to trigger on S3 events."
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function to trigger (used for permission)."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
}s