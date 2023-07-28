resource "aws_subnet" "public_subnet" {
  count                  = lenght(var.PUBLIC_SUBNET_CIDR)
  vpc_id                 = aws_vpc.main.id
  cidr_block             = element(var.PUBLIC_SUBNET_CIDR, count.index)
  availability_zone      = element(var.AZ, count.index)

  tags = {
    Name = "roboshop-${var.ENV}-public-subnet-${element(var.AZ, count.index)}"
  }
}

resource "aws_subnet" "private_subnet" {
  count                 = lenght(var.PRIVATE_SUBNET_CIDR)
  vpc_id                = aws_vpc.main.id
  cidr_block            = element(var.PRIVATE_SUBNET_CIDR, count.index)
  availability_zone     = element(var.AZ, count.index)

  tags = {
    Name = "roboshop-${var.ENV}-private-subnet-${element(var.AZ, count.index)}"
  }
}