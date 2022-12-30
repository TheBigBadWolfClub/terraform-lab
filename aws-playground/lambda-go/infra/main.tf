terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">=1.2.0"
}

provider "aws" {
  profile = "global-sandbox"
  region  = "eu-central-1"
}

variable "app_name" {
  description = "application name"
  default     = "bad-lambda-go"
}

variable "app_env" {
  description = "application environment tag"
  default     = "dev"
}

locals {
  app_id = "${lower(var.app_name)}-${lower(var.app_env)}-${random_id.unique_suffix.hex}"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../build/bin/app"
  output_path = "../build/bin/app.zip"
}

resource "random_id" "unique_suffix" {
  byte_length = 2
}

output "api_url" {
  value = aws_api_gateway_deployment.api_deployment.invoke_url
}