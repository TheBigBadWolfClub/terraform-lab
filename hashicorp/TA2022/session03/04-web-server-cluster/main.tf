resource "aws_instance" "wolf-server" {
  count         = 3
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "Wolf-Server-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.wolf-security-group.id]
  user_data              = <<EOF
#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
/usr/bin/apt-get update
DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get upgrade -yq
/usr/bin/apt-get install apache2 -y
/usr/sbin/ufw allow in "Apache Full"
/bin/echo "The Big Bad Wold Den" >/var/www/html/index.html
instance_ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo $instance_ip >>/var/www/html/index.html
EOF
}
