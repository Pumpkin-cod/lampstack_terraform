variable "vpc_id" {}
variable "alb_sg_id" {}
variable "public_subnet_ids" { type = list(string) }
variable "web_instance_id" {}
