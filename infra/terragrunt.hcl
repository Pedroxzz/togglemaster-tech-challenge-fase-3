locals {
  project_name = "togglemaster"
  environment  = "dev"
  aws_region   = "us-east-1"
}

terragrunt_version_constraint = ">= 0.57.0"

inputs = {
  project_name = local.project_name
  environment  = local.environment
  aws_region   = local.aws_region
}
