
resource "aws_security_group" "wolf-security-group" {
  ingress {
    from_port   = var.http_port
    protocol    = "tcp"
    to_port     = var.http_port
    cidr_blocks = [var.cidr_block_allowed]
  }

  ingress {
    from_port   = var.ssh_port
    protocol    = "tcp"
    to_port     = var.ssh_port
    cidr_blocks = [var.cidr_block_allowed]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}