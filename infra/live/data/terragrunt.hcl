terraform {
  source = "../../modules/data-services"
}

include {
  path = find_in_parent_folders("terragrunt.hcl")
}

dependency "network" {
  config_path = "../network"
}

inputs = {
  project_name       = "togglemaster"
  environment        = "dev"
  aws_region         = "us-east-1"
  vpc_id             = dependency.network.outputs.vpc_id
  vpc_cidr           = "10.30.0.0/16"
  subnet_ids         = dependency.network.outputs.private_subnet_ids
  availability_zones = ["us-east-1a", "us-east-1b"]
  db_master_username = "togglemaster"
  db_master_password = "ToggleMaster123!"
}
