module "vpc" {
  source     = "../mod-vpc"
  name       = var.name
  cidr_block = var.vpc_cidr
  azs        = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "sg" {
  source = "../mod-sg"
  name   = var.name
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source = "../mod-iam"
  name   = var.name
}

module "ecr" {
  source = "../mod-ecr"
  name   = var.name
}

module "alb" {
  source            = "../mod-alb"
  name              = var.name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.sg.alb_sg_id
}

module "ecs" {
  source = "../mod-ecs"

  name                = var.name
  cluster_name        = var.name
  task_exec_role_arn  = module.iam.ecs_exec_role_arn
  task_role_arn       = module.iam.ecs_task_role_arn
  private_subnet_ids  = module.vpc.private_subnet_ids
  ecs_sg_id           = module.sg.ecs_sg_id

  appointment_image   = var.appointment_image
  patient_image       = var.patient_image

  appointment_target_group_arn = module.alb.appointment_tg_arn
  patient_target_group_arn     = module.alb.patient_tg_arn
}

module "monitoring" {
  source = "../mod-monitoring"
  name   = var.name
}

provider "aws" {
  region = var.region
}