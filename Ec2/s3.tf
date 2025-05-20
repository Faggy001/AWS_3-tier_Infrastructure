
 # Create S3 bucket for remote state
provider "aws" {
  region = var.region 
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "groupb-terraform-state" 
  
  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Staging"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
  lifecycle {
    prevent_destroy = true
  }
}


#resource "aws_dynamodb_table" "terraform_locks" {
#  name         = "my-terraform-locks"
 # billing_mode = "PAY_PER_REQUEST"
  #attribute {
   # name = "LockID"
    #type = "S"
  #}
  #hash_key = "LockID"
   # tags = {
    #Name        = "Terraform Lock Table"
    #Environment = "Staging"
  #}
#}
