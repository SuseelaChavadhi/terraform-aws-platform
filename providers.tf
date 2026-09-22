provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "terraform-aws-platform"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "SuseelaChavadhi"
    }
  }
}