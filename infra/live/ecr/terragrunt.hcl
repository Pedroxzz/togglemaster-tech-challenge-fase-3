terraform {
  source = "../../modules/ecr"
}

include {
  path = find_in_parent_folders("terragrunt.hcl")
}

inputs = {
  services = [
    "auth-service",
    "flag-service",
    "targeting-service",
    "evaluation-service",
    "analytics-service"
  ]
}
