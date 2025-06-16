output "s3_bucket_name" {
  description = "The name of the created S3 bucket."
  value       = module.s3_event_bucket.s3_bucket_id
}

output "lambda_function_name" {
  description = "The name of the created Lambda function."
  value       = module.file_logger_lambda.lambda_function_name
}

output "lambda_function_arn" {
  description = "The ARN of the created Lambda function."
  value       = module.file_logger_lambda.lambda_function_arn
}