 data "aws_availability_zones" "available" {

 }
#######  VPC  #######
resource "aws_vpc" "custom-vpc" {
   cidr_block       =  var.cidr-block
   enable_dns_hostnames = true

   tags = {
    Name         = "${var.platform}-${var.env}-vpc"
    Env          = var.env
    OwnerContact = var.OwnerContact
  }
}
#########  IGW - Internet Gateway  ########
resource "aws_internet_gateway" "igw" {
  vpc_id  =  aws_vpc.custom-vpc.id

  tags = {
    Name         = "${var.platform}-${var.env}-IGW"
    Env          = var.env
    OwnerContact = var.OwnerContact
  }
}
#########  Public Subnet  ###########
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.custom-vpc.id
  cidr_block = var.public-subnet-cidr
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name         = "${var.platform}-${var.env}-publicsubnet"
    Env          = var.env
    OwnerContact = var.OwnerContact
  }
}

############  Private Subnet #######
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.custom-vpc.id
  cidr_block = var.private-subnet-cidr

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name         = "${var.platform}-${var.env}-privatesubnet"
    Env          = var.env
    OwnerContact = var.OwnerContact
  }
}

##########   EIP - Elastic IP  ##########
resource "aws_eip" "nat" {
  vpc = true
}
##########  NGW - NAT Gateway  ############
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name         = "${var.platform}-${var.env}-ngw"
    Env          = var.env

  }
}
########  Public RT  ########
resource "aws_route_table" "public-rt" {
   vpc_id = aws_vpc.custom-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name         = "${var.platform}-${var.env}-publicrt"
    Env          = var.env

  }
}
#########  Public1 RTAssociation  ######
resource "aws_route_table_association" "a-public" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

##########  Private RT  ########
resource "aws_route_table" "private-rt" {
   vpc_id = aws_vpc.custom-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name         = "${var.platform}-${var.env}-privatert"
    Env          = var.env

  }
}
#######  Private1 RTAssociation  #####
resource "aws_route_table_association" "a-private" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}
