resource "aws_autoscaling_policy" "wolf-autoscaling-policy" {
  autoscaling_group_name = aws_autoscaling_group.wolf-autoscaling-group.name
  name                   = "wolf-webserver-autoscaling-policy"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50
  }
}