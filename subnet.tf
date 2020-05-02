

variable "internal_nets" {
  type = number
  default = 2
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  count = var.internal_nets

  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true

  tags = {
    status = "public"
  }
}

resource "aws_subnet" "private" {
  count = var.internal_nets

  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.${var.internal_nets+count.index}.0/24"
  map_public_ip_on_launch = true

  tags = {
    status = "private"
  }
}

output "public_nets" {
  value = length(aws_subnet.public[*])
}
