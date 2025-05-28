resource "aws_instance" "private" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  iam_instance_profile   = aws_iam_instance_profile.groupb_profile.name
  vpc_security_group_ids = [aws_security_group.ssh.id, ]
  key_name               = "tier-key"

    user_data = <<-EOF
              #!/bin/bash
              set -xe
              yum update -y
              yum install -y awscli
              yum install -y python3-pip
              pip3 install boto3
              echo "User data script completed" >> /var/log/user_data.log
              EOF
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
  
  #  connection {
    # type        = "ssh"
    # user        = "ec2-user"
    # private_key = file(var.keyPath)
    # host        = self.public_ip
  # }

  # provisioner "file" {
    # source      = "groupB_script.sh"
    # destination = "/tmp/groupB_script.sh"
  # }

  # provisioner "remote-exec" {
    # inline = [
      # "chmod +x /tmp/groupB_script.sh",
      # "bash /tmp/groupB_script.sh "
    # ]
  # }
  #  depends_on = [aws_internet_gateway.main]
}
