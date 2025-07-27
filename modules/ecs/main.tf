resource "aws_ecs_cluster" "main" {
  name = "${var.name}-ecs-cluster"
}

resource "aws_ecs_task_definition" "appointment" {
  family                   = "${var.name}-appointment"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = var.cpu
  memory                  = var.memory
  execution_role_arn      = var.execution_role_arn
  task_role_arn           = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "appointment-container"
      image     = var.appointment_image
      essential = true
      portMappings = [{
        containerPort = 3000
        hostPort      = 3000
      }]
    }
  ])
}

resource "aws_ecs_task_definition" "patient" {
  family                   = "${var.name}-patient"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = var.cpu
  memory                  = var.memory
  execution_role_arn      = var.execution_role_arn
  task_role_arn           = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "patient-container"
      image     = var.patient_image
      essential = true
      portMappings = [{
        containerPort = 3000
        hostPort      = 3000
      }]
    }
  ])
}

resource "aws_ecs_service" "appointment" {
  name            = "${var.name}-appointment-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.appointment.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.private_subnet_ids
    assign_public_ip = false
    security_groups = [var.service_sg_id]
  }
  load_balancer {
    target_group_arn = var.appointment_tg_arn
    container_name   = "appointment-container"
    container_port   = 3000
  }
  depends_on = [aws_ecs_task_definition.appointment]
}

resource "aws_ecs_service" "patient" {
  name            = "${var.name}-patient-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.patient.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.private_subnet_ids
    assign_public_ip = false
    security_groups = [var.service_sg_id]
  }
  load_balancer {
    target_group_arn = var.patient_tg_arn
    container_name   = "patient-container"
    container_port   = 3000
  }
  depends_on = [aws_ecs_task_definition.patient]
}
