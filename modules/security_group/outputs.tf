output "src_security_group_id" {
  description = "The ID of the src security group."
  value       = aws_security_group.src.id
}

output "dst_security_group_id" {
  description = "The ID of the dst security group."
  value       = aws_security_group.dst.id
}
