# Terraform 3-Tier LAMP Stack Application on AWS

## Project Overview
This Terraform project provisions a LAMP stack infrastructure on AWS. It includes a Virtual Private Cloud (VPC) with public and private subnets, security groups, web and application servers, a MySQL RDS database, and an Application Load Balancer (ALB) to distribute traffic to the web tier.

## Architecture
- **VPC Module:** Creates a VPC with public and private subnets, internet gateway, NAT gateway, and route tables.
- **Security Module:** Defines security groups for web, app, database, and ALB tiers with appropriate ingress and egress rules.
- **Web Module:** Deploys EC2 instances in public subnets running Apache and PHP, serving a simple task tracker frontend.
- **App Module:** Deploys EC2 instances in private subnets running PHP scripts that interact with the MySQL database.
- **DB Module:** Provisions a MySQL RDS instance in private subnets with restricted access.
- **ALB Module:** Sets up an Application Load Balancer in public subnets to route HTTP traffic to the web instances.

## Modules Description
- **vpc:** Sets up networking components including VPC, subnets, gateways, and routing.
- **security:** Manages security groups to control access between tiers and the internet.
- **web:** Launches web server instances with PHP and Apache configured.
- **app:** Launches application server instances with PHP scripts for task submission and retrieval.
- **db:** Creates a MySQL RDS instance with subnet group and security.
- **alb:** Configures an ALB with target groups and listeners to distribute traffic.

## Variables
- `aws_region`: AWS region to deploy resources (default: eu-west-1).
- `ami_id`: AMI ID for EC2 instances (default: Amazon Linux 2 AMI).
- `instance_type`: EC2 instance type (default: t2.micro).
- `key_name`: SSH key pair name for EC2 access.
- `vpc_cidr`: CIDR block for the VPC (default: 10.0.0.0/16).
- `public_subnets`: List of CIDRs for public subnets.
- `private_subnets`: List of CIDRs for private subnets.
- `azs`: Availability zones for subnets.
- `db_name`: Database name (default: lampdb).
- `db_username`: Database master username (default: admin).
- `db_password`: Database master password (sensitive).
- `db_instance_class`: RDS instance class (default: db.t3.micro).
- `db_user`: Database user for app connection (default: admin).
- `db_pass`: Database password for app connection (sensitive).

## Outputs
- `vpc_id`: ID of the created VPC.
- `rds_endpoint`: Endpoint of the RDS MySQL database.
- `web_instance_ip`: Public IP of the web instance.
- `web_instance_id`: ID of the web instance.
- `alb_dns_name`: DNS name of the Application Load Balancer.

## Usage Instructions
1. Ensure you have Terraform installed and AWS CLI configured with appropriate credentials.
2. Customize variables in `terraform.tfvars` or override defaults as needed.
3. Initialize Terraform:
   ```
   terraform init
   ```
4. Review the execution plan:
   ```
   terraform plan
   ```
5. Apply the configuration:
   ```
   terraform apply
   ```
6. Access the application via the ALB DNS name or public IP of the web instance.

## Security Considerations
- Security groups restrict access between tiers:
  - ALB and web servers allow HTTP (80) from anywhere.
  - App servers accept HTTP only from web servers.
  - Database accepts MySQL (3306) only from app and web servers.
- SSH access is allowed to web servers on port 22 from anywhere (consider restricting this in production).

## Prerequisites
- Terraform installed (version 0.12+ recommended).
- AWS CLI configured with credentials and default region.
- SSH key pair created in AWS matching the `key_name` variable.

## Live Application URL
Access the deployed application at: [http://app-alb-122902046.eu-west-1.elb.amazonaws.com/](http://app-alb-122902046.eu-west-1.elb.amazonaws.com/)

---

This README provides an overview and instructions for managing the Terraform LAMP stack infrastructure.
