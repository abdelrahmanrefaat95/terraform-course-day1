output "my_public_ip" {
    value = aws_instance.my_instance.public_ip
    description = "The public ip i will use to connect via ssh"
  
}

