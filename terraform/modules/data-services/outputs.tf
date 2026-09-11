output "rds_endpoints" {
  value = aws_rds_cluster.postgres.endpoint
}

output "redis_endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "sqs_queue_url" {
  value = aws_sqs_queue.analytics.url
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.analytics.name
}
