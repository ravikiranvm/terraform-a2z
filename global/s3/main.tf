provider "aws" {
    region = "us-east-1"
}

# S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
    bucket = "terraform-stat-25v001"

    lifecycle {
      prevent_destroy = true
    }
}

# Enable versioning for this bucket
resource "aws_s3_bucket_versioning" "enabled" {
    bucket = aws_s3_bucket.terraform_state.id

    versioning_configuration {
      status = "Enabled"
    }
}

# Encrypt the data at rest in the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
    bucket = aws_s3_bucket.terraform_state.id

    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
}

# Explicitly block the bucket from public access
resource "aws_s3_bucket_public_access_block" "default" {
    bucket = aws_s3_bucket.terraform_state.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

#Backend configuration for terraform state
terraform {
    backend "s3" {
        bucket = "terraform-stat-25v001"
        key    = "global/s3/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}



