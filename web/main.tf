resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
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
\$app_ip = "${var.app_private_ip}";
?>
<h1>Task Tracker</h1>
<form action="http://<?= \$app_ip ?>/submit.php" method="POST">
  <input type="text" name="title" placeholder="Enter task" required />
  <button type="submit">Submit</button>
</form>
<hr>
<h2>Tasks</h2>
<iframe src="http://<?= \$app_ip ?>/tasks.php" width="100%" height="300"></iframe>
EOT
  EOF

  tags = {
    Name = "WebServer"
  }
}

