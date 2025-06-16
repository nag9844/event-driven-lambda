output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = module.s3_bucket.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = module.s3_bucket.bucket_arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda_function.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda_function.lambda_arn
}

output "cloudwatch_log_group" {
  description = "CloudWatch log group for Lambda function"
  value       = module.lambda_function.log_group_name
}