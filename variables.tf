variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "s3-event-lambda-bucket"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "s3-event-processor"
}

variable "ecr_repository_uri" {
  description = "ECR repository URI for Lambda container image"
  type        = string
  default     = "199570228070.dkr.ecr.ap-south-1.amazonaws.com/s3-lambda-processor"
}

variable "image_tag" {
  description = "Container image tag"
  type        = string
  default     = "latest"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "S3EventLambda"
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}