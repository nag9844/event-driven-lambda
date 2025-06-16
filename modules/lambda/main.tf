# IAM Role for Lambda Function
resource "aws_iam_role" "this" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.function_name}-role"
    Environment = var.environment
  }
}

# IAM Policy for Lambda to log to CloudWatch and read from S3
resource "aws_iam_role_policy" "this" {
  name = "${var.function_name}-policy"
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*" # Allows logging to any CloudWatch Logs resource
      },
      {
        Action = [
          "s3:GetObject",
          "s3:GetObjectAcl" # Required if you need to check object ACLs, though not strictly for just filename logging
        ]
        Effect   = "Allow"
        Resource = "${var.s3_bucket_arn}/*" # Restrict to specific bucket if possible
      }
    ]
  })
}

# CloudWatch Log Group for Lambda
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_in_days # Example: 7 days

  tags = {
    Name        = "/aws/lambda/${var.function_name}"
    Environment = var.environment
  }
}

# Lambda Function (Container Image)
resource "aws_lambda_function" "this" {
  function_name = var.function_name
  package_type  = "Image"
  image_uri     = var.image_uri
  role          = aws_iam_role.this.arn
  timeout       = var.timeout_seconds
  memory_size   = var.memory_size_mb

  depends_on = [
    aws_iam_role_policy.this,
    aws_cloudwatch_log_group.this # Ensure log group exists before function tries to log
  ]

  tags = {
    Name        = var.function_name
    Environment = var.environment
  }
}