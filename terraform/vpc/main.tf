# provider "aws" {
#   region = "eu-central-1"  # AWS region
# }

# # Create VPC
# resource "aws_vpc" "main_vpc" {
#   cidr_block = var.vpc_cidr
#   tags = {
#     Name = "main-vpc"
#   }
# }

# # Create Server Subnet
# resource "aws_subnet" "server_subnet" {
#   vpc_id     = aws_vpc.main_vpc.id
#   cidr_block = var.server_subnet_cidr
#   tags = {
#     Name = "server-subnet"
#   }
# }

# # Create Client Subnet
# resource "aws_subnet" "client_subnet" {
#   vpc_id     = aws_vpc.main_vpc.id
#   cidr_block = var.client_subnet_cidr
#   tags = {
#     Name = "client-subnet"
#   }
# }

# # Create Security Group
# resource "aws_security_group" "allow_communication" {
#   vpc_id = aws_vpc.main_vpc.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 8000
#     to_port     = 8000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "allow-communication"
#   }
# }

# # Outputs
# output "vpc_id" {
#   value = aws_vpc.main_vpc.id
# }

# output "server_subnet_id" {
#   value = aws_subnet.server_subnet.id
# }

# output "client_subnet_id" {
#   value = aws_subnet.client_subnet.id
# }

# output "sg_id" {
#   value = aws_security_group.allow_communication.id
# }



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

# Create Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main-igw"
  }
}

# Create Route Table
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"  # Default route to the internet
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "main-route-table"
  }
}

# Associate Route Table with Server Subnet
resource "aws_route_table_association" "server_subnet_association" {
  subnet_id      = aws_subnet.server_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}

# Associate Route Table with Client Subnet
resource "aws_route_table_association" "client_subnet_association" {
  subnet_id      = aws_subnet.client_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}

# Create Server Subnet
resource "aws_subnet" "server_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.server_subnet_cidr
  map_public_ip_on_launch = true  # Automatically assign public IPs

  tags = {
    Name = "server-subnet"
  }
}

# Create Client Subnet
resource "aws_subnet" "client_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.client_subnet_cidr
  map_public_ip_on_launch = true  # Automatically assign public IPs

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
    cidr_blocks = ["0.0.0.0/0"]  # Open SSH to the world
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open port 8000
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
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

output "igw_id" {
  value = aws_internet_gateway.main_igw.id
}
