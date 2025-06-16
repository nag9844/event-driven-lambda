resource "aws_lambda_function" "s3_processor" {
  function_name = var.function_name
  role          = var.lambda_role_arn

  package_type = "Image"
  image_uri    = "${var.ecr_repository_uri}:${var.image_tag}"

  timeout     = 30
  memory_size = 256

  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14

  tags = var.tags
}