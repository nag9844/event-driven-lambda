variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "ecr_repository_uri" {
  description = "ECR repository URI"
  type        = string
}

variable "image_tag" {
  description = "Container image tag"
  type        = string
  default     = "latest"
}

variable "lambda_role_arn" {
  description = "ARN of the Lambda execution role"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}