terraform {
  required_version = ">= 1.5.0"

  # Cost-optimized remote state storage
  # backend "s3" {
  #   bucket         = "blogify-terraform-state"
  #   key            = "dev/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "blogify-lock-table"
  #   encrypt        = true
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.environment
      Project     = "Blogify"
      ManagedBy   = "Terraform"
    }
  }
}
