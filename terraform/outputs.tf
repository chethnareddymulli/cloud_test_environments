output "linux_public_ip" {
  value = aws_instance.linux_server.public_ip
}

output "windows_public_ip" {
  value = aws_instance.windows_server.public_ip
}
