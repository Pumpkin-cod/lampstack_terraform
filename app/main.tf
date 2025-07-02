resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = false

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras enable php8.0
    yum clean metadata
    yum install -y php php-mysqlnd httpd
    systemctl start httpd
    systemctl enable httpd

    # Set permissions
    chown -R apache:apache /var/www/html
    chmod -R 755 /var/www/html

    # Submit.php
    cat <<'EOT' > /var/www/html/submit.php
    <?php
    \$conn = new mysqli("${var.db_host}", "${var.db_user}", "${var.db_pass}", "${var.db_name}");
    if (\$conn->connect_error) {
        die("❌ DB connection failed: " . \$conn->connect_error);
    }
    \$title = \$_POST['title'] ?? '';
    if (!empty(\$title)) {
        \$stmt = \$conn->prepare("INSERT INTO tasks (title) VALUES (?)");
        if (!\$stmt) {
            die("❌ Prepare failed: " . \$conn->error);
        }
        \$stmt->bind_param("s", \$title);
        if (!\$stmt->execute()) {
            die("❌ Execute failed: " . \$stmt->error);
        }
        echo "✅ Task submitted!";
        \$stmt->close();
    } else {
        echo "❌ No task title provided.";
    }
    \$conn->close();
    ?>
    EOT

    # tasks.php
    cat <<'EOT' > /var/www/html/tasks.php
    <?php
    \$conn = new mysqli("${var.db_host}", "${var.db_user}", "${var.db_pass}", "${var.db_name}");
    if (\$conn->connect_error) {
        die("❌ DB connection failed: " . \$conn->connect_error);
    }
    \$result = \$conn->query("SELECT id, title, created_at FROM tasks ORDER BY created_at DESC");
    echo "<ul>";
    while (\$row = \$result->fetch_assoc()) {
        echo "<li><strong>{\$row['title']}</strong> ({\$row['created_at']})</li>";
    }
    echo "</ul>";
    \$conn->close();
    ?>
    EOT

    # healthcheck.php
    echo "<?php http_response_code(200); echo 'OK'; ?>" > /var/www/html/healthcheck.php
  EOF

  tags = {
    Name = "App-Tier"
  }
}

