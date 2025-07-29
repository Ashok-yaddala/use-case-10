data "aws_caller_identity" "current" {}
# S3 bucket for CloudTrail
resource "aws_s3_bucket" "cloudtrail_logs" {
 bucket = var.s3_testing_bucket
 tags = {
   Name        = var.s3_testing_bucket
   Environment = var.project_name
 }
}
# Enable versioning
resource "aws_s3_bucket_versioning" "cloudtrail_versioning" {
 bucket = aws_s3_bucket.cloudtrail_logs.id
 versioning_configuration {
   status = "Enabled"
 }
}
# Enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "trail_logs_encryption" {
 bucket = aws_s3_bucket.cloudtrail_logs.id
 rule {
   apply_server_side_encryption_by_default {
     sse_algorithm = "AES256"
   }
 }
}
# Block public access
resource "aws_s3_bucket_public_access_block" "trail_logs_public_block" {
 bucket                  = aws_s3_bucket.cloudtrail_logs.id
 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}
# ✅ Ownership controls (this is what was missing)
resource "aws_s3_bucket_ownership_controls" "cloudtrail_bucket_acl" {
 bucket = aws_s3_bucket.cloudtrail_logs.id
 rule {
   object_ownership = "BucketOwnerPreferred"
 }
}
# Required S3 bucket policy for CloudTrail
resource "aws_s3_bucket_policy" "cloudtrail_logs_policy" {
 bucket = aws_s3_bucket.cloudtrail_logs.id
 policy = jsonencode({
   Version = "2012-10-17",
   Statement = [
     {
       Sid       = "AWSCloudTrailAclCheck",
       Effect    = "Allow",
       Principal = {
         Service = "cloudtrail.amazonaws.com"
       },
       Action   = "s3:GetBucketAcl",
       Resource = aws_s3_bucket.cloudtrail_logs.arn
     },
     {
       Sid       = "AWSCloudTrailWrite",
       Effect    = "Allow",
       Principal = {
         Service = "cloudtrail.amazonaws.com"
       },
       Action    = "s3:PutObject",
       Resource  = "${aws_s3_bucket.cloudtrail_logs.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
       Condition = {
         StringEquals = {
           "s3:x-amz-acl" = "bucket-owner-full-control"
         }
       }
     }
   ]
 })
}
# CloudWatch log group (optional)
resource "aws_cloudwatch_log_group" "trail_log_group" {
 count             = var.enable_cloudwatch_logs ? 1 : 0
 name              = var.log_group_name != "" ? var.log_group_name : "/aws/cloudtrail/${var.project_name}"
 retention_in_days = 90
}
# IAM Role for CloudTrail (CloudWatch logging)
resource "aws_iam_role" "cloudtrail_role" {
 name = "${var.project_name}-cloudtrail-role"
 assume_role_policy = jsonencode({
   Version = "2012-10-17",
   Statement = [{
     Effect = "Allow",
     Principal = {
       Service = "cloudtrail.amazonaws.com"
     },
     Action = "sts:AssumeRole"
   }]
 })
}
# IAM Policy to write logs to CloudWatch
resource "aws_iam_role_policy" "cloudtrail_logging_policy" {
 name = "cloudtrail-logging-policy"
 role = aws_iam_role.cloudtrail_role.id
 policy = jsonencode({
   Version = "2012-10-17",
   Statement = [
     {
       Effect = "Allow",
       Action = [
         "logs:PutLogEvents",
         "logs:CreateLogStream",
         "logs:CreateLogGroup",
         "logs:DescribeLogStreams"
       ],
       Resource = "*"
     }
   ]
 })
}
# CloudTrail Trail
resource "aws_cloudtrail" "trail" {
 name                          = "${var.project_name}-cloudtrail"
 s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.id
 include_global_service_events = true
 is_multi_region_trail         = true
 enable_logging                = true
 cloud_watch_logs_group_arn = var.enable_cloudwatch_logs ? "${aws_cloudwatch_log_group.trail_log_group[0].arn}:*" : null
 cloud_watch_logs_role_arn  = var.enable_cloudwatch_logs ? aws_iam_role.cloudtrail_role.arn : null
}
