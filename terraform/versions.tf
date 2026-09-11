terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
  }

  # backend "s3" {
  #   bucket         = "togglemaster-terraform-state"
  #   key            = "fase3/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "togglemaster-terraform-lock"
  # }
}

provider "aws" {
  region = var.aws_region
}
