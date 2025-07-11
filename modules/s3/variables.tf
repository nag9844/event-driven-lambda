variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the Lambda function to trigger"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}