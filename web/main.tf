resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
#!/bin/bash
yum update -y
amazon-linux-extras enable php8.0
yum clean metadata
yum install -y php php-mysqlnd httpd
systemctl start httpd
systemctl enable httpd

cat <<EOT > /var/www/html/index.php
<?php
\$host = "lamp-db.cv2ueq6sqd4i.eu-west-1.rds.amazonaws.com";
\$user = "admin";
\$pass = "S3cURe#Pa55!Rds9";
\$dbname = "lampdb";

\$conn = new mysqli(\$host, \$user, \$pass, \$dbname);
if (\$conn->connect_error) {
    die("❌ Connection failed: " . \$conn->connect_error);
}
echo "✅ Connected to MySQL RDS successfully!";
\$conn->close();
?>
EOT
  EOF

  tags = {
    Name = "WebServer"
  }
}
