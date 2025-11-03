# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

# ECS Outputs
output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = module.ecs.cluster_id
}

output "ecs_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  value       = module.ecs.ecs_execution_role_arn
}

# RDS Outputs
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

output "rds_security_group_id" {
  description = "The ID of the security group attached to the RDS instance"
  value       = module.rds.db_security_group_id
}

# Common Outputs
output "environment" {
  description = "The environment name"
  value       = var.environment
}

# ALB Outputs (to be uncommented when ALB module is implemented)
# output "alb_dns_name" {
#   description = "The DNS name of the load balancer"
#   value       = module.alb.alb_dns_name
# }
# 
# output "alb_zone_id" {
#   description = "The zone ID of the load balancer"
#   value       = module.alb.alb_zone_id
# }
# 
# output "alb_https_listener_arn" {
#   description = "The ARN of the HTTPS listener"
#   value       = module.alb.https_listener_arn
# }

# CloudFront Outputs (to be uncommented when CloudFront module is implemented)
# output "cloudfront_distribution_id" {
#   description = "The ID of the CloudFront distribution"
#   value       = module.cloudfront.distribution_id
# }
# 
# output "cloudfront_domain_name" {
#   description = "The domain name of the CloudFront distribution"
#   value       = module.cloudfront.domain_name
# }

# S3 Bucket Outputs (to be uncommented when S3 module is implemented)
# output "s3_bucket_arn" {
#   description = "The ARN of the S3 bucket"
#   value       = module.s3.bucket_arn
# }
# 
# output "s3_bucket_name" {
#   description = "The name of the S3 bucket"
#   value       = module.s3.bucket_name
# }
