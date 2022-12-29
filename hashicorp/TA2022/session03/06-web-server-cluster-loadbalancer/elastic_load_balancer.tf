resource "aws_elb" "wolf-elastic-load-balancer" {
  name               = "wolf-elastic-load-balancer"
  availability_zones = var.availability_zones
  security_groups    = [aws_security_group.wolf-elb-security-group.id]
  listener {
    instance_port     = var.http_port
    instance_protocol = "http"
    lb_port           = var.http_port
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:${var.http_port}/"
    interval            = 30
  }
}