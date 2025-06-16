variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "ap-south-1" # Mumbai
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod, staging)."
  type        = string
  default     = "dev"
}

variable "s3_bucket_name" {
  description = "A unique name for the S3 bucket where files will be uploaded."
  type        = string
}

variable "lambda_function_name" {
  description = "A unique name for the Lambda function."
  type        = string
  default     = "s3-file-logger-lambda"
}

variable "lambda_image_uri" {
  description = "The ECR image URI for your containerized Lambda function."
  type        = string
  # Example: "ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/your-repo-name:latest"
}