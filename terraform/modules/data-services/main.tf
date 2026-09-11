resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "rds" {
  name        = "${var.project_name}-${var.environment}-rds-sg"
  description = "Security group para bancos RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.30.0.0/16"]
  }
}

resource "aws_rds_cluster" "postgres" {
  cluster_identifier     = "${var.project_name}-${var.environment}-postgres"
  engine                 = "aurora-postgresql"
  availability_zones     = var.availability_zones
  database_name          = "togglemaster"
  master_username        = var.db_master_username
  master_password        = var.db_master_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true
}

resource "aws_rds_cluster_instance" "postgres" {
  count              = 3
  identifier         = "${var.project_name}-${var.environment}-postgres-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.postgres.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.postgres.engine
  publicly_accessible = false
}

resource "aws_security_group" "redis" {
  name        = "${var.project_name}-${var.environment}-redis-sg"
  description = "Security group para Redis"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.30.0.0/16"]
  }
}

resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.project_name}-${var.environment}-elasticache-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = "${var.project_name}-${var.environment}-redis"
  description                = "Redis para o evaluation-service"
  node_type                  = "cache.t3.micro"
  num_cache_clusters         = 1
  engine                     = "redis"
  parameter_group_name       = "default.redis7"
  port                       = 6379
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  security_group_ids         = [aws_security_group.redis.id]
  transit_encryption_enabled = false
  automatic_failover_enabled = false
}

resource "aws_sqs_queue" "analytics" {
  name                       = "${var.project_name}-${var.environment}-analytics-queue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
}

resource "aws_dynamodb_table" "analytics" {
  name         = "${var.project_name}Analytics"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "event_id"

  attribute {
    name = "event_id"
    type = "S"
  }
}
