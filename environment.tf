# create VPC
resource "aws_vpc" "MYTFVPC" {
  cidr_block           = "${var.aws_vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.aws_vpc_name}"
  }
}

#create internet gateway
resource "aws_internet_gateway" "Igw" {
  vpc_id = "${aws_vpc.MYTFVPC.id}"

  tags = {
    Name = "MYTFC-IGW"
  }
}

#create subnets
resource "aws_subnet" "PublicSubnet" {
  count                   = "${length(var.aws_subnet_cidr)}"
  vpc_id                  = "${aws_vpc.MYTFVPC.id}"
  cidr_block              = "${element(var.aws_subnet_cidr,count.index)}"
  availability_zone       = "${element(var.aws_subnet_AZ,count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet-${count.index+1}"
  }
}

#create a route table attach it to internet gateway and associate both subnets
resource "aws_route_table" "TFPUBLICRT" {
  vpc_id = "${aws_vpc.MYTFVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.Igw.id}"
  }

  tags = {
    Name = "TF-PUBLIC-RT"
  }
}

resource "aws_route_table_association" "TFPUBLICRT-AS" {
  count          = "${length(var.aws_subnet_cidr)}"
  subnet_id      = "${element(aws_subnet.PublicSubnet.*.id,count.index)}"
  route_table_id = "${aws_route_table.TFPUBLICRT.id}"
}

terraform {
  backend "s3" {
    encrypt        = "true"
    bucket         = "terraformawsnorge"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    region         = "us-east-1"
  }
}

resource "aws_security_group" "webservers-sg" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "${aws_vpc.MYTFVPC.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 80
    to_port   = 80
    protocol  = "TCP"

    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Webservers-SG"
  }
}
