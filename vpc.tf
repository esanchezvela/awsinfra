
#######################################################################################################
#######################################################################################################
#######################################################################################################
###
### resource "aws_default_vpc" "my_default_vpc" {
###     arn                              = "arn:aws:ec2:us-west-1:906251579196:vpc/vpc-1a4e7b7d"
###     assign_generated_ipv6_cidr_block = false
###     cidr_block                       = "172.31.0.0/16"
###     default_network_acl_id           = "acl-e953948f"
###     default_route_table_id           = "rtb-053a9b63"
###     default_security_group_id        = "sg-a52a83df"
###     dhcp_options_id                  = "dopt-0c42666b"
###     enable_classiclink               = false
###     enable_classiclink_dns_support   = false
###     enable_dns_hostnames             = true
###     enable_dns_support               = true
###     id                               = "vpc-1a4e7b7d"
###     instance_tenancy                 = "default"
###     main_route_table_id              = "rtb-053a9b63"
###     owner_id                         = "906251579196"
###     tags                             = {
###         "Name" = "Default VPC"
###     }
### }
###
#######################################################################################################
#######################################################################################################
#######################################################################################################



provider "aws" {
  profile  = "default"
  region   = "us-west-2"
}

resource "aws_vpc"  "my_vpc" {
  cidr_block  = "10.0.0.0/16"
  enable_dns_support  = True
  enable_dns_hostnames = True
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}


output "vpid" {
    value = aws_default_vpc.my_default_vpc.id
}

output "default_cidr" {
    value = aws_default_vpc.my_default_vpc.cidr_block
}

