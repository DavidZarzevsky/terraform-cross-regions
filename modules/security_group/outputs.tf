output "first_security_group_id" {
  description = "The ID of the first security group."
  value       = aws_security_group.first.id
}

output "second_security_group_id" {
  description = "The ID of the second security group."
  value       = aws_security_group.second.id
}
