locals {
  vpc_cidr           = "192.168.0.0/16"
  availability_zones = data.aws_availability_zones.az.names
}

# Availability Zones
data "aws_availability_zones" "az" {}

# VPC
resource "aws_vpc" "default" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Default Security Group
resource "aws_default_security_group" "default_sg" {
  vpc_id = aws_vpc.default.id
}

# Subnets
resource "aws_subnet" "public_subnets" {
  count = length(local.availability_zones)

  vpc_id                  = aws_vpc.default.id
  cidr_block              = cidrsubnet(local.vpc_cidr, 4, count.index)
  availability_zone       = local.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${local.availability_zones[count.index]}",
    Type = "Public"
  }
}

resource "aws_subnet" "webui_private_subnets" {
  count = length(local.availability_zones)

  vpc_id            = aws_vpc.default.id
  cidr_block        = cidrsubnet(local.vpc_cidr, 4, count.index + length(local.availability_zones)) # Calculate subnet CIDR (add an offset because of public subnets)
  availability_zone = local.availability_zones[count.index]
  tags = {
    Name = "webui-private-subnet-${local.availability_zones[count.index]}",
    Type = "Private"
  }
}

resource "aws_subnet" "bag_private_subnets" {
  count = length(local.availability_zones)

  vpc_id            = aws_vpc.default.id
  cidr_block        = cidrsubnet(local.vpc_cidr, 4, count.index + 2 * length(local.availability_zones)) # Calculate subnet CIDR (add an offset because of public subnets)
  availability_zone = local.availability_zones[count.index]
  tags = {
    Name = "bag-private-subnet-${local.availability_zones[count.index]}",
    Type = "Private"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.default.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "rt-public"
  }
}

resource "aws_route" "igw_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_rt_association" {
  count = length(local.availability_zones)

  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}

# NAT Gateway
resource "aws_eip" "eip" {}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.allocation_id
  subnet_id     = aws_subnet.public_subnets[0].id
  depends_on    = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_route_table" {
  count = length(local.availability_zones)

  vpc_id = aws_vpc.default.id
  tags = {
    Name = "rt-private"
  }
}

resource "aws_route" "private_nat_route" {
  count = length(local.availability_zones)

  route_table_id         = aws_route_table.private_route_table[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw.id
}

resource "aws_route_table_association" "private_rt_association_webui" {
  count = length(local.availability_zones)

  route_table_id = aws_route_table.private_route_table[count.index].id
  subnet_id      = aws_subnet.webui_private_subnets[count.index].id
}

resource "aws_route_table_association" "private_rt_association_bag" {
  count = length(local.availability_zones)

  route_table_id = aws_route_table.private_route_table[count.index].id
  subnet_id      = aws_subnet.bag_private_subnets[count.index].id
}
