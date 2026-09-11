terraform {
  source = "../../modules/eks"
}

include {
  path = find_in_parent_folders("terragrunt.hcl")
}

inputs = {
  project_name       = "togglemaster"
  environment        = "dev"
  cluster_name       = "togglemaster-dev-cluster"
  cluster_version    = "1.30"
  node_instance_type = "t3.medium"
  desired_size       = 2
  max_size           = 3
  min_size           = 1
  subnet_ids         = ["subnet-12345678", "subnet-87654321"]
  node_subnet_ids    = ["subnet-12345678", "subnet-87654321"]
  lab_role_arn       = ""
}
