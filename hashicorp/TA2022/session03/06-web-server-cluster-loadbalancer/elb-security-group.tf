
resource "aws_security_group" "wolf-elb-security-group" {
  description = "Wolf Terraform lessons"
  name        = "wolf-elb-security-group"
  ingress {
    from_port   = var.http_port
    protocol    = "tcp"
    to_port     = var.http_port
    cidr_blocks = [var.cidr_block_allowed]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wolf-elb-security-group"
  }
}