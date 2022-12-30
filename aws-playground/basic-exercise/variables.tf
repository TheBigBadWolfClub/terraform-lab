
variable "instance_name" {
  description = "value of the Name tag for the EC2 instance"
  default     = "EC2-ExampleAppServerInstance"
  type        = string
  validation {
    condition     = length(var.instance_name) > 4 && substr(var.instance_name, 0, 4) == "EC2-"
    error_message = "The instance_name value mast start with \"EC2-\""
  }
}