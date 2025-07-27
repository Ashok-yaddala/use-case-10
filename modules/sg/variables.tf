variable "name" {
  description = "Name prefix for the security groups"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where SGs are created"
  type        = string
}