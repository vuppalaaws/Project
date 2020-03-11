
# get available az
data "aws_availability_zones" "available" {}
####VPC######

resource "aws_vpc" "custom-vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name         = "${var.platform}-${var.env}-vpc"
    Env          = "${var.env}"
    OwnerContact = "${var.OwnerContact}"
  }
}

####Internet Gateway######
resource "aws_internet_gateway" "internetgateway" {
  vpc_id = "${aws_vpc.custom-vpc.id}"

  tags = {
    Name         = "${var.platform}-${var.env}-igw"
    Env          = "${var.env}"
    OwnerContact = "${var.OwnerContact}"
  }
}

#####Public Subnets
resource "aws_subnet" "publicsubnet" {
  vpc_id                  = "${aws_vpc.custom-vpc.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block              = "${var.public_subnet1}"
  map_public_ip_on_launch = true

  tags = {
    Name         = "${var.platform}-${var.env}-publicsubnet"
    Env          = "${var.env}"
    OwnerContact = "${var.OwnerContact}"
  }
}


#### Private Subnets
resource "aws_subnet" "privatesubnet" {
  vpc_id     = "${aws_vpc.custom-vpc.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block = "${var.private_subnet1}"

  tags = {
    Name         = "${var.platform}-${var.env}-privatesubnet"
    Env          = "${var.env}"
    OwnerContact = "${var.OwnerContact}"
  }
}



##########Public Route Table#########
resource "aws_route_table" "publicroutetable" {
  vpc_id = "${aws_vpc.custom-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internetgateway.id}"
  }

  tags = {
    Name         = "${var.platform}-${var.env}-publicroutetable"
    Env          = "${var.env}"
  }
}

#######Public Route Table Association######

resource "aws_route_table_association" "publicsubnet1sassociation" {
  subnet_id      = "${aws_subnet.publicsubnet1.id}"
  route_table_id = "${aws_route_table.publicroutetable.id}"
}





#############NAT GATEWAY &&& EIP ################

resource "aws_eip" "elasticipprivate" {
  vpc = true
  depends_on = ["aws_internet_gateway.internetgateway"]
}

resource "aws_nat_gateway" "natgateway" {
  allocation_id = "${aws_eip.elasticipprivate.id}"
  subnet_id     = "${aws_subnet.publicsubnet1.id}"
    tags {
    Name         = "${var.platform}-${var.env}-natgateway"
    Env          = "${var.env}"
    
  }
}

########Private Route Table##########
resource "aws_route_table" "privateroutetable" {
  vpc_id = "${aws_vpc.custom-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.natgateway.id}"
  }

  tags = {
    Name         = "${var.platform}-${var.env}-privateroutetable"
    Env          = "${var.env}"
  }
}

#######Private Route Table Association ####

resource "aws_route_table_association" "privatesubnet1sassociation" {
  subnet_id      = "${aws_subnet.privatesubnet1.id}"
  route_table_id = "${aws_route_table.privateroutetable.id}"
}




  
