output "vpc_id" {
  value = module.vpc.vpc_id
  description = "The VPC ID."
}

output "vpc" {
  value = module.vpc
  description = "The VPC object for further attribute inspection."
}

output "region" {
  value = data.aws_region.current.name
  description = "The VPC region."
}

output "local_storage" {
  value = aws_s3_bucket.local_storage
  description = "Local storage bucket."
}

output "public_subnets_ids" {
  value = module.vpc.public_subnets
  description = "Public Subnets IDs."
}

output "private_subnets_ids" {
  value = module.vpc.private_subnets
  description = "Private Subnets IDs."
}

output "database_subnets" {
  value = module.vpc.database_subnets
  description = "Database Subnets IDs."
}