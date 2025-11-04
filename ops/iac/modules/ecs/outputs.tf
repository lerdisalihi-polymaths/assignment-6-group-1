output "cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.main.id
}

output "cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_auto_scaling_group_name" {
  description = "The name of the auto scaling group for ECS container instances"
  value       = aws_autoscaling_group.ecs_nodes.name
}

output "ecs_instance_profile_name" {
  description = "The name of the IAM instance profile for ECS container instances"
  value       = aws_iam_instance_profile.ecs_instance_profile.name
}
