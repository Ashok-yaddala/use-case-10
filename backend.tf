terraform {
  backend "s3" {
    bucket  = "myaws-ashok-buckethcl"
    key     = "uc/terraform.tfstate"
    region  = "us-east-1"
  }
}