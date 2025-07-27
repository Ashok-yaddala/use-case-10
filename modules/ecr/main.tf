resource "aws_ecr_repository" "appointment" {
  name = "${var.name}-appointment-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "${var.name}-appointment-service"
  }
}

resource "aws_ecr_repository" "patient" {
  name = "${var.name}-patient-service"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "${var.name}-patient-service"
  }
}