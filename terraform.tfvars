name                  = "dev"
vpc_cidr              = "10.0.0.0/16"
azs                   = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs  = ["10.0.3.0/24", "10.0.4.0/24"]
region = "ap-south-1"

# These values should be replaced with your actual ECR image URIs
appointment_image      = "173003893026.dkr.ecr.ap-south-1.amazonaws.com/appointment-service:latest"
patient_image          = "173003893026.dkr.ecr.ap-south-1.amazonaws.com/patient-service:latest"