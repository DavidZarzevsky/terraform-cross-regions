output "src_caller_identity" {
  description = "The caller identity of the src AWS provider."
  value       = data.aws_caller_identity.src
}

output "src_transit_gateway_id" {
  description = "The ID of the src transit gateway."
  value       = aws_ec2_transit_gateway.src.id
}

output "dst_transit_gateway_id" {
  description = "The ID of the dst transit gateway."
  value       = aws_ec2_transit_gateway.dst.id
}

output "peering_attachment_id" {
  description = "The ID of the peering attachment."
  value       = aws_ec2_transit_gateway_peering_attachment.gtw_peer.id
}

output "peering_accepter_attachment_id" {
  description = "The ID of the peering attachment accepter."
  value       = aws_ec2_transit_gateway_peering_attachment_accepter.peer_attach.id
}

output "src_internet_gateway_id" {
  description = "The ID of the src internet gateway."
  value       = aws_internet_gateway.src.id
}
