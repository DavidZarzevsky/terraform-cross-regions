output "ServerPublicIP_first_private_subnet" {
  value       = aws_instance.first_instance_private.public_ip
  description = "Public IP address of the first instance"
  depends_on  = [aws_instance.first_instance_private]
}

output "ServerPublicIP_first_public_subnet" {
  value       = aws_instance.first_instance_public.public_ip
  description = "Public IP address of the first instance"
  depends_on  = [aws_instance.first_instance_public]
}

output "ServerPublicIP_second_private_subnet" {
  value       = aws_instance.second_instance_private.public_ip
  description = "Public IP address of the second instance"
  depends_on  = [aws_instance.second_instance_private]
}

output "ServerPrivateIP_first_private_subnet" {
  value       = aws_instance.first_instance_private.private_ip
  description = "Private IP address of the first instance"
  depends_on  = [aws_instance.first_instance_private]
}

output "ServerPrivateIP_second_private_subnet" {
  value       = aws_instance.second_instance_private.private_ip
  description = "Private IP address of the second instance"
  depends_on  = [aws_instance.second_instance_private]
}
