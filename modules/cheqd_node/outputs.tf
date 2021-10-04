# Output variable definitions

output "dns_name" {
  description = "DNS name of the load balancer."
  value       = aws_lb.cheqd_node.dns_name
}
output "genesis_arn" {
  value       = aws_secretsmanager_secret.genesis.arn
  description = "genesis arn."
}

output "node_key_arn" {
  value       = aws_secretsmanager_secret.node_key.arn
  description = "node_key arn."
}

output "priv_validator_key_arn" {
  value       = aws_secretsmanager_secret.priv_validator_key.arn
  description = "priv_validator_key arn."
}

output "cheqd_node_vpc_id" {
  description = "VPC id."
  value       = aws_vpc.cheqd_node.id
}

output "cheqd_node_public_subnet_id" {
  description = "Public subnet 1."
  value       = aws_subnet.public_cheqd_node.id
}

output "cheqd_node_public_subnet_2_id" {
  description = "Public subnet 2."
  value       = aws_subnet.public_cheqd_node_2.id
}

output "cheqd_node_private_subnet_id" {
  description = "Private subnet 1."
  value       = aws_subnet.cheqd_node.id
}

output "cheqd_node_private_subnet_2_id" {
  description = "Private subnet 2."
  value       = aws_subnet.cheqd_node_2.id
}