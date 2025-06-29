resource "aws_instance" "private" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.ssh.id, ]
  key_name               = "tier-key"

    tags = merge(
    local.required_tags,
    tomap({ "Name" = "${local.prefix}-private-ec2" })
  )
}


resource "aws_instance" "public" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  iam_instance_profile   = aws_iam_instance_profile.groupb_profile.name
  vpc_security_group_ids = [aws_security_group.ssh.id, ]
  key_name               = "tier-key"
  associate_public_ip_address = true
  tags = merge(
    local.required_tags,
    tomap({ "Name" = "${local.prefix}-public-ec2" })
  )
  
