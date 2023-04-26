resource "aws_vpc" "eks-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    name = "eks-vpc"
  }
  
}

resource "aws_internet_gateway" "eks-gateway" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Name = "gateway"
  }
}
resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.eks-vpc.id
  cidr_block = "10.0.101.0/24"
  availability_zone = "us-east-1a" 

  map_public_ip_on_launch = true

}

resource "aws_subnet" "public_subnet2" {
  vpc_id = aws_vpc.eks-vpc.id
  cidr_block = "10.0.102.0/24"
  availability_zone = "us-east-1b"

  map_public_ip_on_launch = true

}
resource "aws_eip" "eks-ip" {
  depends_on    = [aws_internet_gateway.eks-gateway]
  vpc           = true
}
# resource "aws_eip" "nat" {
#   count = 3

#   vpc = true
# }

resource "aws_route_table" "eks-route-table" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-gateway.id
  }
}

resource "aws_route_table_association" "eks-route-asso1" {

  subnet_id      = aws_subnet.public_subnet1.id 
  route_table_id = aws_route_table.eks-route-table.id
}
# resource "aws_route_table_association" "eks-route-asso2" {

#   subnet_id      = aws_subnet.public_subnet2.id 
#   route_table_id = aws_route_table.eks-route-table.id
# }