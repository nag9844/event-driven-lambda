# Event-Driven Lambda from S3 Upload

This project creates an AWS infrastructure using Terraform that triggers a containerized Lambda function when files are uploaded to an S3 bucket. The Lambda function logs the filename to CloudWatch.

## Architecture

- **S3 Bucket**: Configured with event notifications
- **Lambda Function**: Containerized function that processes S3 events
- **IAM Roles & Policies**: Proper permissions for S3 and Lambda integration
- **CloudWatch**: For logging Lambda execution
- **GitHub Actions**: CI/CD pipeline for automated deployment

## Prerequisites

- AWS CLI configured
- Terraform installed
- Docker installed
- GitHub repository with proper secrets configured

## Required GitHub Secrets

Add these secrets to your GitHub repository:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

## Quick Start

1. Clone this repository
2. Update `terraform/terraform.tfvars` with your values
3. Push to GitHub to trigger the deployment pipeline
4. Upload a file to the created S3 bucket to test

## File Structure

```
├── terraform/
│   ├── modules/
│   │   ├── s3/
│   │   ├── lambda/
│   │   └── iam/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── lambda/
│   ├── src/
│   │   └── index.py
│   ├── Dockerfile
│   └── requirements.txt
├── .github/
│   └── workflows/
│       └── deploy.yml
└── README.md
```