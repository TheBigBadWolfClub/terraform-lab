resource "aws_autoscaling_group" "wolf-autoscaling-group" {
  launch_configuration = aws_launch_configuration.wolf-launch-config.id
  load_balancers       = [aws_elb.wolf-elastic-load-balancer.name]
  availability_zones   = var.availability_zones
  max_size             = 10
  min_size             = 2
  desired_capacity     = 3

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "wolf-webservers"
  }
}