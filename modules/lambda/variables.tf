variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "image_uri" {
  description = "The URI of the Docker image in ECR for the Lambda function."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket this Lambda will interact with (for IAM policy)."
  type        = string
}

variable "timeout_seconds" {
  description = "The maximum amount of time (in seconds) that the Lambda function can run."
  type        = number
  default     = 30 # Default to 30 seconds
}

variable "memory_size_mb" {
  description = "The amount of memory (in MB) that the Lambda function has available."
  type        = number
  default     = 128 # Default to 128 MB
}

variable "log_retention_in_days" {
  description = "The number of days to retain logs in CloudWatch Logs."
  type        = number
  default     = 7 # Default to 7 days
}