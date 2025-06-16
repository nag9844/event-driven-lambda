# Deployment Guide

This guide walks you through deploying the S3 Event-Driven Lambda infrastructure.

## Prerequisites

1. **AWS Account**: Active AWS account with appropriate permissions
2. **GitHub Repository**: Repository with this code
3. **AWS CLI**: Installed and configured locally (for manual deployment)
4. **Terraform**: Installed locally (for manual deployment)
5. **Docker**: Installed locally (for building containers)

## Automated Deployment (Recommended)

### 1. Setup GitHub Secrets

In your GitHub repository, go to Settings > Secrets and Variables > Actions, and add:

- `AWS_ACCESS_KEY_ID`: Your AWS access key
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret key

### 2. Configure Variables

Copy `terraform/terraform.tfvars.example` to `terraform/terraform.tfvars` and update:

```hcl
aws_region = "ap-south-1"
bucket_name = "your-unique-bucket-name"
lambda_function_name = "s3-event-processor"
ecr_repository_uri = "YOUR_ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com/s3-lambda-processor"
```

### 3. Deploy

Push to the `main` branch to trigger automatic deployment:

```bash
git add .
git commit -m "Deploy S3 Event Lambda infrastructure"
git push origin main
```

The GitHub Actions workflow will:
1. Build and push the Lambda container to ECR
2. Plan the Terraform changes
3. Apply the infrastructure changes
4. Test the deployment

## Manual Deployment

### 1. Build and Push Container

```bash
# Login to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin YOUR_ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com

# Create ECR repository
aws ecr create-repository --repository-name s3-lambda-processor --region ap-south-1

# Build and push
cd lambda
docker build -t YOUR_ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com/s3-lambda-processor:latest .
docker push YOUR_ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com/s3-lambda-processor:latest
```

### 2. Deploy with Terraform

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Testing the Deployment

### 1. Upload a Test File

```bash
# Get the bucket name from Terraform output
BUCKET_NAME=$(terraform output -raw s3_bucket_name)

# Upload a test file
echo "Hello, World!" > test.txt
aws s3 cp test.txt s3://$BUCKET_NAME/
```

### 2. Check Lambda Logs

```bash
# Get the log group name
LOG_GROUP=$(terraform output -raw cloudwatch_log_group)

# View recent logs
aws logs describe-log-streams --log-group-name $LOG_GROUP
aws logs get-log-events --log-group-name $LOG_GROUP --log-stream-name [STREAM_NAME]
```

## Monitoring and Troubleshooting

### CloudWatch Metrics

Monitor your Lambda function through CloudWatch:
- Duration
- Error count
- Invocation count
- Throttles

### Common Issues

1. **Permission Denied**: Check IAM roles and policies
2. **Container Image Not Found**: Verify ECR repository and image tags
3. **S3 Event Not Triggering**: Check S3 event notification configuration
4. **Lambda Timeout**: Increase timeout in `terraform/modules/lambda/main.tf`

### Useful Commands

```bash
# Check Lambda function
aws lambda get-function --function-name s3-event-processor

# List S3 events
aws s3api get-bucket-notification-configuration --bucket YOUR_BUCKET_NAME

# Test Lambda function directly
aws lambda invoke --function-name s3-event-processor --payload '{}' response.json
```

## Cleanup

To destroy all resources:

```bash
# Using the cleanup script
./scripts/cleanup.sh

# Or manually with Terraform
cd terraform
terraform destroy
```

## Security Considerations

1. **IAM Permissions**: Follow least privilege principle
2. **S3 Bucket Policies**: Restrict access appropriately
3. **Lambda Function**: Validate input data
4. **Secrets Management**: Use AWS Secrets Manager for sensitive data
5. **VPC Configuration**: Consider running Lambda in VPC for enhanced security

## Cost Optimization

1. **Lambda Memory**: Right-size memory allocation
2. **Log Retention**: Set appropriate CloudWatch log retention periods
3. **S3 Storage Class**: Use appropriate storage classes for different use cases
4. **Monitoring**: Set up billing alerts