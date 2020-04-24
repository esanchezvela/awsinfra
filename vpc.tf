
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

output "default_cidr" {
    value = aws_vpc.main_vpc.cidr_block
}

