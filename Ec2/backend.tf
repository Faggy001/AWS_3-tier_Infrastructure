 terraform {
   backend "s3" {
     bucket         = "groupb-terraform-state"
     key            = "tfstate/terraform.tfstate"
     region         = "ca-central-1"
     encrypt        = true
     dynamodb_table = "my-terraform-locks"
   }
 }


