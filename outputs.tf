output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = module.ecs.cluster_name
}

output "cloudwatch_log_group" {
  description = "ECS log group name"
  value       = module.monitoring.cloudwatch_log_group_name
}
