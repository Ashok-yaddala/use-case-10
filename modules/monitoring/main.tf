resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.name}-logs"
  retention_in_days = 7
  tags = {
    Name = "${var.name}-ecs-logs"
  }
}

resource "aws_cloudtrail" "trail" {
  name                          = "${var.name}-trail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }
  tags = {
    Name = "${var.name}-trail"
  }
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = "${var.name}-trail-bucket"
  force_destroy = true
  tags = {
    Name = "${var.name}-trail-bucket"
  }
}
