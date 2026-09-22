output "vpc_id" {
  description = "Development VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Development public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Development private subnet IDs"
  value       = module.vpc.private_subnet_ids
}