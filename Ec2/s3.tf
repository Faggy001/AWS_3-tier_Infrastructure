provider "aws" {
  region = var.region 
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "groupb-terraform-state005" 
  
  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Staging"
  }
 
   lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true # Blocks public access granted through bucket ACLs .
  block_public_policy     = true # Blocks public access granted through bucket policies.
  ignore_public_acls      = true # Ignores public ACLs set on the bucket when checking for public access.
  restrict_public_buckets = true # Enforces the public access block settings on the bucket.
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "my-terraform-locks01"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key = "LockID"
    tags = {
    Name        = "Terraform Lock Table"
    Environment = "Staging"
  }
}
