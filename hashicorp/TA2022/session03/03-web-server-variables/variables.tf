variable "aws_region" {
  description = "The AWS region to use"
  default     = "eu-central-1"
}
variable "aws_profile" {
  description = "The AWS profile to use"
  default     = "global-sandbox"
}
variable "ami" {
  description = "The AMI to use for the instance."
  default     = "ami-06ce824c157700cd2"
}
variable "instance_type" {
  description = "The type of instance to start."
  default     = "t2.micro"
}
variable "key_name" {
  description = "The key name that should be used for the instance"
  default     = "wolf-terraform-lessons"
}

variable "cidr_block_allowed" {
  default = "95.93.201.48/32"
}
variable "http_port" {
  default = 80
}
variable "ssh_port" {
  default = 22
}