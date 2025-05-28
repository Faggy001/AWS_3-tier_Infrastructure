resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [aws_subnet.public.id]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
ingress {
  protocol   = "tcp"
  rule_no    = 130
  action     = "allow"
  cidr_block = "10.0.2.0/24"
  from_port  = 1024
  to_port    = 65535
}

  egress {
    protocol   = "-1"   
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
 }

}


resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [aws_subnet.private.id]
 
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 22
    to_port    = 22
  }
  ingress {
  protocol   = "tcp"
  rule_no    = 120
  action     = "allow"
  cidr_block = "0.0.0.0/0"
  from_port  = 1024
  to_port    = 65535
}
  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "10.0.1.0/24"    
    from_port  = 8080
    to_port    = 8080
  }

  egress {
    protocol   = "-1"   
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
