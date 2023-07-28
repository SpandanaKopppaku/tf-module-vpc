resource "aws_subnet" "public_subnet" {
  count         = lenght(var.PUBLIC_SUBNET_CIDR)
  vpc_id        = aws_vpc.main.id
  cidr_block    = element(var.PUBLIC_SUBNET_CIDR, count.index)

  tags = {
    Name = "roboshop-${var.ENV}-public-subnet-${element(var.AZ, count.index)}"
  }
}