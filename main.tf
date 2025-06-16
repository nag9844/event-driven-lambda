# S3 Bucket Module
module "s3_bucket" {
  source = "./modules/s3"
  
  bucket_name   = var.bucket_name
  lambda_arn    = module.lambda_function.lambda_arn
  
  tags = var.common_tags
}

# IAM Module
module "iam" {
  source = "./modules/iam"
  
  lambda_function_name = var.lambda_function_name
  s3_bucket_name      = var.bucket_name
  
  tags = var.common_tags
}

# Lambda Function Module
module "lambda_function" {
  source = "./modules/lambda"
  
  function_name     = var.lambda_function_name
  ecr_repository_uri = var.ecr_repository_uri
  image_tag         = var.image_tag
  lambda_role_arn   = module.iam.lambda_role_arn
  
  tags = var.common_tags
  
  depends_on = [module.iam]
}

# Grant S3 permission to invoke Lambda
resource "aws_lambda_permission" "s3_invoke" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.lambda_function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_bucket.bucket_arn
}