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

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.14.1"

  name                 = "seller_reviews"
  cidr                 = "10.101.0.0/16"
  azs                  = ["eu-central-1a", "eu-central-1b"]
  public_subnets       = ["10.101.4.0/24", "10.101.5.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true

}

resource "aws_db_subnet_group" "seller_subnet" {
  name       = "seller_reviews"
  subnet_ids = module.vpc.public_subnets
  tags = {
    Name = "seller_subnet"
  }
}

resource "aws_security_group" "seller_rds" {
  name   = "seller_reviews"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "seller_rds"
  }
}


resource "aws_rds_cluster_instance" "seller_db" {
  count              = 1
  identifier         = "aurora-cluster-sellerdb-${count.index}"
  cluster_identifier = aws_rds_cluster.seller_cluster.id
  engine             = aws_rds_cluster.seller_cluster.engine
  engine_version     = aws_rds_cluster.seller_cluster.engine_version
  instance_class     = "db.t3.small"
}

resource "aws_rds_cluster" "seller_cluster" {
  cluster_identifier = "aurora-cluster-seller-review"
  availability_zones = ["eu-central-1a", "eu-central-1b"]

  database_name   = "sellerratings"
  master_username = "root"
  master_password = var.db_password

  engine         = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.07.1"

  db_subnet_group_name   = aws_db_subnet_group.seller_subnet.name
  vpc_security_group_ids = [aws_security_group.seller_rds.id]


  port = 3306

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.seller_param_group.name

  skip_final_snapshot = true
}


resource "aws_rds_cluster_parameter_group" "seller_param_group" {
  name   = "seller-reviews"
  family = "aurora-mysql5.7"

  parameter {
    name         = "log_bin_trust_function_creators"
    value        = "1"
    apply_method = "immediate"
  }
}





output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_rds_cluster_instance.seller_db[0].endpoint
  //sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_rds_cluster_instance.seller_db[0].port
  //sensitive   = true
}




variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}