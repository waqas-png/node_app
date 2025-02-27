resource "aws_instance" "nginx_server" {
  ami           = "ami-04b4f1a9cf54c11d0" 
  instance_type = var.instance_type
  vpc_security_group_ids = [module.security_group.security_group_id]
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "Nginx-WebServer"
  }
}

