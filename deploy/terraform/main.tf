resource "aws_vpc" "spring_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "spring_vpc"
  }
}

resource "aws_subnet" "spring_subnet" {
  vpc_id                  = aws_vpc.spring_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "sa-east-1a"
  map_public_ip_on_launch = true


  tags = {
    Name = "spring_subnet_pub"
  }
}

resource "aws_internet_gateway" "spring_gateway" {
  vpc_id = aws_vpc.spring_vpc.id

  tags = {
    Name = "spring_gateway"
  }
}

resource "aws_route_table" "spring_route_table" {
  vpc_id = aws_vpc.spring_vpc.id

  tags = {
    Name = "spring_route_table"
  }
}

resource "aws_route" "spring_route" {
  route_table_id         = aws_route_table.spring_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.spring_gateway.id
}

resource "aws_route_table_association" "spring_route_table_association" {
  route_table_id = aws_route_table.spring_route_table.id
  subnet_id      = aws_subnet.spring_subnet.id
}

resource "aws_instance" "spring_ec2" {
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.spring_key.id
  vpc_security_group_ids = [aws_security_group.spring_security_group.id]
  subnet_id              = aws_subnet.spring_subnet.id

  ami = data.aws_ami.spring_ami.id

  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 8
  }

  tags = {
    "Name" = "spring_ec2"
  }
}