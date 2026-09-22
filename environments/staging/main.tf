terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "terraform-aws-platform"
      Environment = "staging"
      ManagedBy   = "Terraform"
    }
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name = "staging-platform"

  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "iam" {
  source = "../../modules/iam"

  cluster_name = "staging-platform"
  environment  = "staging"
}

module "security" {
  source = "../../modules/security"

  cluster_name = "staging-platform"
  vpc_id       = module.vpc.vpc_id
  environment  = "staging"
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = "staging-platform"
  kubernetes_version = "1.33"

  subnet_ids      = module.vpc.private_subnet_ids
  node_subnet_ids = module.vpc.private_subnet_ids

  cluster_role_arn = module.iam.eks_cluster_role_arn
  node_role_arn    = module.iam.eks_node_role_arn

  encryption_key_arn = module.security.eks_encryption_key_arn

  node_instance_types = ["t3.medium"]

  node_desired_size = 2
  node_min_size     = 1
  node_max_size     = 3

  environment = "staging"
}