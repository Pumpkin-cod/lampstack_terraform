variable "ami_id" {
  description = "Amazon Machine Image ID for the App EC2 (Amazon Linux 2 preferred)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the App EC2 (e.g., t2.micro)"
  type        = string
}

variable "subnet_id" {
  description = "Private subnet ID where the App EC2 should be deployed"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID allowing traffic from the Web EC2"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair to SSH into the App instance"
  type        = string
}

variable "db_host" {
  description = "RDS endpoint or private IP of the database server"
  type        = string
}

variable "db_user" {
  description = "Database username for MySQL authentication"
  type        = string
}

variable "db_pass" {
  description = "Database password for MySQL authentication"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name (e.g., lampdb)"
  type        = string
}

