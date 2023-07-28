# Provisions EIP needed for NAT Gateway

resource "aws_eip" "ngw_eip" {
  vpc       = true

  tags = {
    Name    = "roboshop-${var.ENV}-ngw-eip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_eip.id
  subnet_id     = aws_subnet.public_subnet.*.id[0]

  tags = {
    Name = "roboshop-${var.ENV}-ngw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway and EIP for the ngw 
  depends_on = [aws_eip.ngw_eip, aws_internet_gateway.igw]
}