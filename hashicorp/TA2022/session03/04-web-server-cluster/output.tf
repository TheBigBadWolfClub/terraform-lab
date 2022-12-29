output "public_ip" {
  value = aws_instance.wolf-server.*.public_ip
}