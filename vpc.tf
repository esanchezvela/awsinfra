
provider "aws" {
  profile  = "default"
  region   = "us-west-2"
}

resource "aws_vpc"  "main_vpc" {
  cidr_block  = "10.0.0.0/16"
  enable_dns_support  = true
  enable_dns_hostnames = true
}


output "vpid" {
    value = aws_vpc.main_vpc.id
}

resource "aws_security_group" "allow_public" {
  name = "allow_public"
  description = " Allow traffic from my IP to port 22"
  vpc_id = aws_vpc.main_vpc.id
}
    
resource "aws_security_group" "allow_internal" {
  name = "allow_internal"
  description = " Allow traffic from my IP to port 22"
  vpc_id = aws_vpc.main_vpc.id
}
    
resource "aws_security_group_rule" "incomming_public_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "72.11.45.87/32" ]
  security_group_id = aws_security_group.allow_public.id
}

resource "aws_security_group_rule" "incomming_public_self" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "all"
  self = true
  security_group_id = aws_security_group.allow_public.id
}

resource "aws_security_group_rule" "incomming_internal_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = aws_security_group.allow_public.id
  security_group_id = aws_security_group.allow_internal.id
}

resource "aws_security_group_rule" "incomming_internal_self" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "all"
  self = true
  security_group_id = aws_security_group.allow_internal.id
}

output "default_cidr" {
    value = aws_vpc.main_vpc.cidr_block
}

