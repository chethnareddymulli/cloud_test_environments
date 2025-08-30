provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "test_env_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TestEnvVPC"
  }
}

# Subnets
resource "aws_subnet" "linux_subnet" {
  vpc_id     = aws_vpc.test_env_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "LinuxSubnet" }
}

resource "aws_subnet" "windows_subnet" {
  vpc_id     = aws_vpc.test_env_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "WindowsSubnet" }
}

# Security Group
resource "aws_security_group" "allow_ssh_rdp" {
  name        = "allow_ssh_rdp"
  description = "Allow SSH for Linux and RDP for Windows"
  vpc_id      = aws_vpc.test_env_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Linux EC2
resource "aws_instance" "linux_server" {
  ami           = "ami-0c94855ba95c71c99" # Ubuntu 22.04 LTS example
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.linux_subnet.id
  security_groups = [aws_security_group.allow_ssh_rdp.name]
  key_name = "your-key-name"

  tags = { Name = "LinuxServer" }
}

# Windows EC2
resource "aws_instance" "windows_server" {
  ami           = "ami-0b2f6494ff0b07a0e" # Windows Server example
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.windows_subnet.id
  security_groups = [aws_security_group.allow_ssh_rdp.name]
  key_name = "your-key-name"

  tags = { Name = "WindowsServer" }
}
