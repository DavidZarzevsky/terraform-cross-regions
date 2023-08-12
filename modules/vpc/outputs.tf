output "first_vpc_id" {
  description = "The ID of the first VPC."
  value       = aws_vpc.first.id
}

output "second_vpc_id" {
  description = "The ID of the second VPC."
  value       = aws_vpc.second.id
}
