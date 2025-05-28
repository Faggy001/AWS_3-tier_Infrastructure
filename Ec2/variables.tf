variable "region" {
  type    = string
  default = "ca-central-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_list" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "prefix" {
  default = "GroupB"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
  default     = "groupb-db"
}

variable "db_username" {
  description = "The username for the RDS database"
  type        = string
  default     = "groupB"
}

variable "Environment" {
  default = "Staging"
  
}

# variable "keyPath" {
  # type    = string
  # default = "~/week1/Ec2/tier-key.pem"
# }