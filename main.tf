resource "aws_key_pair" "my_key" {
  key_name   = "my-demo-key"
  public_key = file(var.key-path)
}

# Create a security group
resource "aws_security_group" "my_sg" {
  name        = "demo-security-group"
  description = "Allow SSH and HTTP traffic"

  # Inbound rule for SSH (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound rule for HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "my_instance" {
  ami             = "ami-0866a3c8686eaeeba"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_sg.name]

  tags = {
    Name = "MyDemoEC2"
  }
}

