
 terraform {
   backend "s3" {
     bucket         = "my-terraform-state"
     key            = "tfstate/terraform.tfstate"
     region         = "ap-south-1"
     encrypt        = true
     dynamodb_table = "my-terraform-locks"
   }
 }

 # Create S3 bucket for remote state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state"
  versioning {
    enabled = true
  }
}


# Create DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "my-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key = "LockID"
}


