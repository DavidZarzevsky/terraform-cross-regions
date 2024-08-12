output "src_vpc_id" {
  description = "The ID of the src VPC."
  value       = aws_vpc.src.id
}

output "dst_vpc_id" {
  description = "The ID of the dst VPC."
  value       = aws_vpc.dst.id
}
