variable "project_name" {
 description = "Name of the project"
 type        = string
}
variable "environment" {
 description = "Deployment environment (dev/stage/prod)"
 type        = string
}
variable "s3_testing_bucket" {
 description = "S3 bucket to store CloudTrail logs"
 type        = string
}
variable "enable_cloudwatch_logs" {
 description = "Enable CloudWatch logging integration"
 type        = bool
 default     = false
}
variable "log_group_name" {
 description = "Custom name for CloudWatch log group (optional)"
 type        = string
 default     = ""
}