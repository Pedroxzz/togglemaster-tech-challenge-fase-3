terraform {
  source = "../../modules/networking"
}

include {
  path = find_in_parent_folders("terragrunt.hcl")
}

inputs = {
  project_name       = "togglemaster"
  environment        = "dev"
  vpc_cidr           = "10.30.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
  public_subnets     = ["10.30.1.0/24", "10.30.2.0/24"]
  private_subnets    = ["10.30.11.0/24", "10.30.12.0/24"]
}
