output "vpc_id" {
  value = module.vpc.vpc_id
}
output "rds_endpoint" {
  value = module.db.rds_endpoint
}
output "web_instance_ip" {
  value = module.web.web_instance_ip
}
output "web_instance_id" {
  value = module.web.web_instance_id
} 
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

