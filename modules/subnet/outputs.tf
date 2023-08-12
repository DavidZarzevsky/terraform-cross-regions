output "first_private_subnet_id" {
  description = "The ID of the first private subnet."
  value       = aws_subnet.first_private.id
}

output "second_private_subnet_id" {
  description = "The ID of the second private subnet."
  value       = aws_subnet.second_private.id
}

output "first_public_subnet_id" {
  description = "The ID of the first public subnet."
  value       = aws_subnet.first_public.id
}
