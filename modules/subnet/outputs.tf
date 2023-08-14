output "src_private_subnet_id" {
  description = "The ID of the src private subnet."
  value       = aws_subnet.src_private.id
}

output "dst_private_subnet_id" {
  description = "The ID of the dst private subnet."
  value       = aws_subnet.dst_private.id
}

output "src_public_subnet_id" {
  description = "The ID of the src public subnet."
  value       = aws_subnet.src_public.id
}
