output "ServerPublicIP_src_private_subnet" {
  value       = aws_instance.src_instance_private.public_ip
  description = "Public IP address of the src instance"
  depends_on  = [aws_instance.src_instance_private]
}

output "ServerPublicIP_src_public_subnet" {
  value       = aws_instance.src_instance_public.public_ip
  description = "Public IP address of the src instance"
  depends_on  = [aws_instance.src_instance_public]
}

output "ServerPublicIP_dst_private_subnet" {
  value       = aws_instance.dst_instance_private.public_ip
  description = "Public IP address of the dst instance"
  depends_on  = [aws_instance.dst_instance_private]
}

output "ServerPrivateIP_src_private_subnet" {
  value       = aws_instance.src_instance_private.private_ip
  description = "Private IP address of the src instance"
  depends_on  = [aws_instance.src_instance_private]
}

output "ServerPrivateIP_dst_private_subnet" {
  value       = aws_instance.dst_instance_private.private_ip
  description = "Private IP address of the dst instance"
  depends_on  = [aws_instance.dst_instance_private]
}
