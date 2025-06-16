resource "aws_s3_bucket" "event_bucket" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "event_bucket_versioning" {
  bucket = aws_s3_bucket.event_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "event_bucket_encryption" {
  bucket = aws_s3_bucket.event_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "event_bucket_pab" {
  bucket = aws_s3_bucket.event_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_notification" "event_notification" {
  bucket = aws_s3_bucket.event_bucket.id

  lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = ""
    filter_suffix       = ""
  }

  depends_on = [aws_s3_bucket.event_bucket]
}