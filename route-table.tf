# Create Public Route Table

resource "aws_route_table" "public_rt" {
  vpc_id            = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "roboshop-${var.ENV}-public-rt"
  }
}

# Associates the route table to public subnet

resource "aws_route_table_association" "public_subnet_rt_association" {
  count          = lenght(aws_subnet.public_subnet.*.id)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Create Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id            = aws_vpc.main.id

        route {
            cidr_block      = "10.0.0.0/0"
            gateway_id      = aws_internet_gateway.ngw.id
        }

  tags = {
    Name = "roboshop-${var.ENV}-private-rt"
  }
}

# Associates the route table to private subnet

resource "aws_route_table_association" "private_subnet_rt_association" {
  count          = lenght(aws_subnet.private_subnet.*.id)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}