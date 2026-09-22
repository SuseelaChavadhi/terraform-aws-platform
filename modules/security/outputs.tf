output "eks_cluster_security_group_id" {
  description = "Security group ID for the EKS cluster"
  value       = aws_security_group.eks_cluster.id
}

output "eks_encryption_key_arn" {
  description = "ARN of the KMS key used for EKS secrets encryption"
  value       = aws_kms_key.eks.arn
}