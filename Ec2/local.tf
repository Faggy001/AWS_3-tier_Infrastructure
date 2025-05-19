locals {
  prefix = var.prefix
  required_tags = {
    Environment = "Staging"
    Owner       = "Group-B"
    Managed_by = "Terraform"
  }
}