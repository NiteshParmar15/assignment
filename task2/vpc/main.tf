
resource "aws_vpc" "myVPC" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "myIGW" {

  vpc_id = aws_vpc.myVPC.id
  tags = {
    "Name" = var.igw_tag
  }
  depends_on = [
    aws_vpc.myVPC
  ]
}


resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.public_subnets_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.public_subnet_tag
  }
  depends_on = [
    aws_vpc.myVPC
  ]
}
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.private_subnets_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.private_subnet_tag
  }
  depends_on = [
    aws_vpc.myVPC
  ]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = var.public_route_table_tag
  }
  depends_on = [
    aws_vpc.myVPC
  ]
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myIGW.id
  depends_on = [
    aws_vpc.myVPC,
    aws_internet_gateway.myIGW
  ]
}
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = var.private_route_table_tag
  }
  depends_on = [
    aws_vpc.myVPC
  ]
}


resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
  depends_on = [
    aws_subnet.public_subnet,
    aws_route_table.public_route_table
  ]
}
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
  depends_on = [
    aws_subnet.private_subnet,
    aws_route_table.private_route_table
  ]
}


resource "aws_security_group" "sg" {
  name        = "torum_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.myVPC.id

  ingress = [
    {
      description      = "HTTPS traffic"
      from_port        = 443   
      to_port          = 443    
      protocol         = "tcp" # 
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "HTTP traffic"
      from_port        = 80   
      to_port          = 80    
      protocol         = "tcp" # 
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Outbound rule"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = var.security_group
  }
  depends_on = [
    aws_vpc.myVPC
  ]
}