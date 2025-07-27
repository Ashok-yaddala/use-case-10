variable "name" {
  description = "Prefix for all resources"
  type        = string
}

variable "execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  type        = string
}

variable "task_role_arn" {
  description = "ECS Task Role ARN"
  type        = string
}

variable "appointment_image" {
  description = "ECR image URI for appointment-service"
  type        = string
}

variable "patient_image" {
  description = "ECR image URI for patient-service"
  type        = string
}

variable "cpu" {
  description = "Task CPU"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Task Memory"
  type        = string
  default     = "512"
}

variable "desired_count" {
  description = "Number of desired tasks"
  type        = number
  default     = 2
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "service_sg_id" {
  description = "Security group ID for ECS services"
  type        = string
}

variable "appointment_tg_arn" {
  description = "Target group ARN for appointment service"
  type        = string
}

variable "patient_tg_arn" {
  description = "Target group ARN for patient service"
  type        = string
}
