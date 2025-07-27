output "appointment_service_repo_url" {
  description = "ECR URL for Appointment Service"
  value       = aws_ecr_repository.appointment.repository_url
}

output "patient_service_repo_url" {
  description = "ECR URL for Patient Service"
  value       = aws_ecr_repository.patient.repository_url
}