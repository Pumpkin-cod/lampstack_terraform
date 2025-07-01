resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name
  associate_public_ip_address = false

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras enable php8.0
    yum clean metadata
    yum install -y php php-mysqlnd httpd
    systemctl start httpd
    systemctl enable httpd

    echo "<?php echo 'App Tier is running!'; ?>" > /var/www/html/index.php
  EOF

  tags = {
    Name = "App-Tier"
  }
}
