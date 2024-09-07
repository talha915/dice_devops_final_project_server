# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main-vpc"
  }
}

# Create a subnet for the server
resource "aws_subnet" "server_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.server_subnet_cidr
  tags = {
    Name = "server-subnet"
  }
}

# Create a subnet for the client
resource "aws_subnet" "client_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.client_subnet_cidr
  tags = {
    Name = "client-subnet"
  }
}

# Create a security group for communication between instances
resource "aws_security_group" "allow_communication" {
  vpc_id = aws_vpc.main_vpc.id

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP for FastAPI
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
