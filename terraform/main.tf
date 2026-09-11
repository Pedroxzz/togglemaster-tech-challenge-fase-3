module "networking" {
  source = "./modules/networking"

  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "data_services" {
  source = "./modules/data-services"

  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.private_subnet_ids
  availability_zones = var.availability_zones
  db_master_username = var.db_master_username
  db_master_password = var.db_master_password
}

module "eks" {
  source = "./modules/eks"

  project_name       = var.project_name
  environment        = var.environment
  cluster_name       = "${var.project_name}-${var.environment}-cluster"
  subnet_ids         = module.networking.private_subnet_ids
  node_subnet_ids    = module.networking.private_subnet_ids
  cluster_version    = var.eks_cluster_version
  node_instance_type = var.eks_node_instance_type
  desired_size       = var.eks_node_desired_size
  max_size           = var.eks_node_max_size
  min_size           = var.eks_node_min_size
  vpc_id             = module.networking.vpc_id
  lab_role_arn       = ""
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  services = [
    "auth-service",
    "flag-service",
    "targeting-service",
    "evaluation-service",
    "analytics-service"
  ]
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "rds_endpoints" {
  value = module.data_services.rds_endpoints
}

output "redis_endpoint" {
  value = module.data_services.redis_endpoint
}

output "sqs_queue_url" {
  value = module.data_services.sqs_queue_url
}

output "dynamodb_table_name" {
  value = module.data_services.dynamodb_table_name
}

output "ecr_repository_urls" {
  value = module.ecr.repository_urls
}
