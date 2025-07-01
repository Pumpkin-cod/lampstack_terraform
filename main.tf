provider "aws" {
  region = var.aws_region 
}

module "vpc" {
  source          = "./vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

module "security" {
  source = "./security"
  vpc_id = module.vpc.vpc_id
}

module "web" {
  source             = "./web"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnets[0]
  security_group_id  = module.security.web_sg_id
  key_name           = var.key_name
}

module "db" {
  source            = "./db"
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class
  subnet_ids        = module.vpc.private_subnets
  security_group_id = module.security.db_sg_id
}

module "app" {
  source             = "./app"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = module.vpc.private_subnets[0]
  security_group_id  = module.security.app_sg_id
  key_name           = var.key_name
}

module "alb" {
  source             = "./alb"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnets
  alb_sg_id          = module.security.alb_sg_id
  web_instance_id    = module.web.web_instance_id
}
