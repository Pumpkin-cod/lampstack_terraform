variable "ami_id" {
  description = "AMI ID for the web server"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the web server"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the web server"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}