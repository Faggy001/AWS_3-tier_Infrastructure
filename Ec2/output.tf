output "ec2_public_ip" {
  description = "public ip for ec2"
  value       = aws_instance.public.public_ip
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private.id
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.postgres.endpoint
}

output "ec2_private_ip" {
  description = "The private ip for ec2"
  value       = aws_instance.private.private_ip
}

output "region_name" {
  value = data.aws_region.current.name
}

output "private_subnet_azs" {
  value = [
    aws_subnet.private.availability_zone,
    aws_subnet.private1.availability_zone
  ]
}

output "s3-bucket-name" {
  value = aws_s3_bucket.terraform_state.id

}


#output "key_name" {
 # value = aws_key_pair.tier.key_name
#}

#output "private_key_path" {
#  value     = "${path.module}/tier-key.pem"
 # sensitive = true
#}
