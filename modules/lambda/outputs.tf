output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.s3_processor.function_name
}

output "lambda_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.s3_processor.arn
}

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}