output "first_caller_identity" {
  description = "The caller identity of the first AWS provider."
  value       = data.aws_caller_identity.first
}

output "first_transit_gateway_id" {
  description = "The ID of the first transit gateway."
  value       = aws_ec2_transit_gateway.first.id
}

output "second_transit_gateway_id" {
  description = "The ID of the second transit gateway."
  value       = aws_ec2_transit_gateway.second.id
}

output "peering_attachment_id" {
  description = "The ID of the peering attachment."
  value       = aws_ec2_transit_gateway_peering_attachment.gtw_peer.id
}

output "peering_accepter_attachment_id" {
  description = "The ID of the peering attachment accepter."
  value       = aws_ec2_transit_gateway_peering_attachment_accepter.peer_attach.id
}

output "first_internet_gateway_id" {
  description = "The ID of the first internet gateway."
  value       = aws_internet_gateway.first.id
}
