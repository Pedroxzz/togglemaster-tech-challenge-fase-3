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

output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
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
