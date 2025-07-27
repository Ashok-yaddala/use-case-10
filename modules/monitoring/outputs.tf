output "cloudwatch_log_group_name" {
  description = "Name of the ECS CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.ecs_logs.name
}

output "cloudtrail_bucket" {
  description = "S3 bucket used for CloudTrail logs"
  value       = aws_s3_bucket.cloudtrail_bucket.id
}