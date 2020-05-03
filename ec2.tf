
resource "aws_instance" "public" {
  count = var.internal_nets

  ami  = "ami-0d6621c01e8c2de2c"
  instance_type = "t2.micro"
  key_name = "oregon"
  subnet_id = aws_subnet.public[count.index].id
  security_groups = [ aws_security_group.allow_public.id ]

  tags = {
    "type" = "public"
  }
}

resource "aws_instance" "private" {
  count = var.internal_nets

  ami  = "ami-0d6621c01e8c2de2c"
  instance_type = "t2.micro"
  key_name = "oregon"
  subnet_id = aws_subnet.private[count.index].id
  security_groups = [ aws_security_group.allow_internal.id ]

  tags = {
    "type" = "public"
  }
}
