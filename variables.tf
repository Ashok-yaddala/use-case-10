variable "name" {
  description = "Environment or name prefix"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  type        = list(string)
}

variable "appointment_image" {
  description = "ECR image URI for appointment-service"
  type        = string
}

variable "patient_image" {
  description = "ECR image URI for patient-service"
  type        = string
}
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}