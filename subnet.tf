

data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_subnet" "public" {

  count = length(aws_availability_zones.available)

  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.0.${count.index}/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
}

