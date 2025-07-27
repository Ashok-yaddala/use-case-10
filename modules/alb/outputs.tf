output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.main.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.main.dns_name
}

output "appointment_tg_arn" {
  description = "Target group ARN for appointment"
  value       = aws_lb_target_group.appointment.arn
}

output "patient_tg_arn" {
  description = "Target group ARN for patient"
  value       = aws_lb_target_group.patient.arn
}