

resource "aws_route_table" "r" {
   vpc_id =  aws_vpc.main_vpc.id 

   route {
     gateway_id = aws_internet_gateway.gw.id
     cidr_block = "0.0.0.0/0"
   }
   tags = {
     Name = "main"
   }
}

resource "aws_route_table" "nat_r" {
   count = var.internal_nets
   vpc_id =  aws_vpc.main_vpc.id 

   route {
     gateway_id = aws_nat_gateway.nat[count.index].id
     cidr_block = "0.0.0.0/0"
   }
   tags = {
     Name = "nat"
     nat_gw = aws_nat_gateway.nat[count.index].id
   }
}

resource "aws_route_table_association" "public" {
    count = var.internal_nets
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.r.id
}

resource "aws_route_table_association" "nat_assoc" {
    count = var.internal_nets

    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.nat_r[count.index].id
}
