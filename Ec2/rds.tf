resource "random_password" "rds_password" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "rds_password" {
  name = "rds-password"
}

resource "aws_secretsmanager_secret_version" "rds_password" {
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = jsonencode({ password = random_password.rds_password.result })
}

resource "aws_db_instance" "postgres" {
  identifier              = "${var.db_name}-postgres"
  engine                 = "postgres"
  engine_version         = "14.10"
  instance_class          = "db.t3.micro"
  allocated_storage       = 30
  username                = var.db_username
  password                = random_password.rds_password.result
  vpc_security_group_ids  = [aws_security_group.rds.id]
  db_subnet_group_name    = aws_db_subnet_group.main.name
  skip_final_snapshot     = true
  tags = merge(
    local.required_tags,
    tomap({ "Name" = "${local.prefix}-postgres" })
  )
}

resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.private.id]
  tags = merge(
    local.required_tags,
    tomap({ "Name" = "${local.prefix}-db-subnet" })
  )
}
