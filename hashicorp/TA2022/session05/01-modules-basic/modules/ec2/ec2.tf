resource "aws_instance" "wolf-server" {
  ami           = "ami-06ce824c157700cd2"
  instance_type = "t2.micro"
  key_name      = "wolf-terraform-lessons"
  tags = {
    Name = "Wolf-Server-${var.environment-type}"
  }
}