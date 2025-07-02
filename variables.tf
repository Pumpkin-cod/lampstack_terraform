variable "aws_region" {
  default = "eu-west-1"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0803576f0c0169402"  # Update to your region
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH Key pair name"
  type        = string
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "db_name" {
  default = "lampdb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}
variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_user" {
  description = "Username for the RDS database"
  type        = string
  default     = "admin"
}

variable "db_pass" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}
