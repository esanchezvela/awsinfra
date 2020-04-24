

provider "aws" {
  profile  = "default"
  region   = "us-west-2"
}

resource "aws_vpc"  "main_vpc" {
  cidr_block  = "10.0.0.0/16"
  enable_dns_support  = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id
}


output "vpid" {
    value = aws_default_vpc.main_default_vpc.id
}

output "default_cidr" {
    value = aws_default_vpc.main_default_vpc.cidr_block
}

