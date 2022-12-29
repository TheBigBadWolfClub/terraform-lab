output "public_dns" {
  value = aws_elb.wolf-elastic-load-balancer.dns_name
}