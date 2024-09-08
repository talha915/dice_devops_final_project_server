provider "aws" {
  region = "eu-central-1"  # AWS region
}

# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main-vpc"
  }
}

# Create Server Subnet
resource "aws_subnet" "server_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.server_subnet_cidr
  tags = {
    Name = "server-subnet"
  }
}

# Create Client Subnet
resource "aws_subnet" "client_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.client_subnet_cidr
  tags = {
    Name = "client-subnet"
  }
}

# Create Security Group
resource "aws_security_group" "allow_communication" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-communication"
  }
}

# Outputs
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "server_subnet_id" {
  value = aws_subnet.server_subnet.id
}

output "client_subnet_id" {
  value = aws_subnet.client_subnet.id
}

output "sg_id" {
  value = aws_security_group.allow_communication.id
}
