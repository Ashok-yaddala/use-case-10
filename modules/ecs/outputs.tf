output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value       = aws_ecs_cluster.main.id
}

output "appointment_service_name" {
  description = "Name of the appointment service"
  value       = aws_ecs_service.appointment.name
}

output "patient_service_name" {
  description = "Name of the patient service"
  value       = aws_ecs_service.patient.name
}