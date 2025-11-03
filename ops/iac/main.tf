terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  
  backend "s3" {
    # This will be configured when setting up the backend
    # bucket = "your-terraform-state-bucket"
    # key    = "dev/terraform.tfstate"
    # region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Environment = var.environment
      Terraform   = "true"
      Project     = var.project_name
    }
  }
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  
  tags = local.common_tags
}

# ECS Cluster Module
module "ecs" {
  source = "./modules/ecs"
  
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  
  private_subnet_ids = module.vpc.private_subnet_ids
  
  instance_type    = var.ecs_instance_type
  min_size         = var.ecs_min_size
  max_size         = var.ecs_max_size
  desired_capacity = var.ecs_desired_capacity
  
  enable_container_insights = var.enable_container_insights
  log_retention_in_days    = var.log_retention_in_days
  
  tags = local.common_tags
}

# RDS Module
module "rds" {
  source = "./modules/rds"
  
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  
  private_subnet_ids = module.vpc.private_subnet_ids
  
  # Security group from ECS that needs database access
  ecs_security_group_id = module.ecs.ecs_security_group_id
  
  # Database configuration
  db_engine         = var.db_engine
  db_engine_version = var.db_engine_version
  db_instance_class = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  
  # Database credentials - in production, use AWS Secrets Manager
  db_username = var.db_username
  db_password = var.db_password
  db_name     = var.db_name
  
  # Monitoring
  monitoring_interval = var.rds_monitoring_interval
  
  tags = local.common_tags
}

# CloudWatch Alarms Module (to be implemented)
# module "monitoring" {
#   source = "./modules/cloudwatch"
#   
#   environment = var.environment
#   
#   # RDS related alarms
#   rds_instance_id = module.rds.db_instance_id
#   
#   # ECS related alarms
#   ecs_cluster_name = module.ecs.cluster_name
#   
#   # SNS topic for alerts
#   alarm_sns_topic_arn = aws_sns_topic.alerts.arn
#   
#   tags = local.common_tags
# }

# Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "rds_database_name" {
  description = "The name of the database"
  value       = module.rds.db_instance_database_name
}

output "rds_username" {
  description = "The master username for the RDS instance"
  value       = module.rds.db_instance_username
  sensitive   = true
}
