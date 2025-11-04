variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the RDS instance will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID of the ECS tasks that need to access the database"
  type        = string
}

# Database configuration
variable "db_engine" {
  description = "Database engine type (e.g., postgres, mysql, etc.)"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "14.4"
}

variable "db_parameter_group_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "postgres14"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "The upper limit to which RDS can automatically scale the storage"
  type        = number
  default     = 100
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

data "aws_caller_identity" "current" {}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for encryption"
  type        = string
  default     = null
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = 5432
}

# Backup & maintenance
variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = "03:00-06:00"
}

variable "maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

# Security
variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
  default     = true
}

# Monitoring
variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = true
}

variable "performance_insights_retention_period" {
  description = "Amount of time in days to retain Performance Insights data"
  type        = number
  default     = 7
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected"
  type        = number
  default     = 60
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = string
  default     = null
}

# High availability
variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

# Maintenance
variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

# CloudWatch Logs
data "aws_region" "current" {}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch logs"
  type        = list(string)
  default     = ["postgresql", "upgrade"]
}

# Alarms
variable "alarm_actions" {
  description = "The list of actions to execute when the alarm transitions to the ALARM state"
  type        = list(string)
  default     = []
}

# Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
