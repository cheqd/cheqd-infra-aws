# Output variable definitions

output "dns_name" {
  description = "DNS name of the load balancer."
  value       = aws_lb.cheqd_node.dns_name
}

output "genesis_seed_arn" {
  value       = aws_secretsmanager_secret.genesis_seed.arn
  description = "genesis arn."
}

output "node_key_seed_arn" {
  value       = aws_secretsmanager_secret.node_key_seed.arn
  description = "node_key arn."
}

output "priv_validator_key_seed_arn" {
  value       = aws_secretsmanager_secret.priv_validator_key_seed.arn
  description = "priv_validator_key arn."
}