

data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_subnet" "public" {

  count = length(data.aws_availability_zones.available.names)

  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
}

