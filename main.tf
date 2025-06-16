module "s3_event_bucket" {
  source = "./modules/s3"

  bucket_name          = var.s3_bucket_name
  lambda_function_arn  = module.file_logger_lambda.lambda_function_arn
  lambda_function_name = module.file_logger_lambda.lambda_function_name
  environment          = var.environment
}

module "file_logger_lambda" {
  source = "./modules/lambda"

  function_name       = var.lambda_function_name
  image_uri           = var.lambda_image_uri
  environment         = var.environment
  s3_bucket_arn       = module.s3_event_bucket.s3_bucket_arn
  timeout_seconds     = 30
  memory_size_mb      = 128
  log_retention_in_days = 7
}