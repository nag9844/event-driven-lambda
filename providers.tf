terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use an appropriate version constraint
    }
  }
}

provider "aws" {
  region = var.aws_region
}