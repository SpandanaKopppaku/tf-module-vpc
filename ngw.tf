# Provisions EIP needed for NAT Gateway

resource "aws_eip" "ngw_eip" {
  vpc       = true

  tags = {
    Name    = "roboshop-${var.ENV}-ngw-eip"
  }
}


resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.public_subnet.*.id[0]

  tags = {
    Name = "roboshop-${var.ENV}-ngw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}