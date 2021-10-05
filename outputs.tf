# Output variable definitions

output "node_dns_names" {
  description = "DNS names of the nodes."
  value       = [for node in module.node : node.dns_name]
}

output "seed_node_dns_names" {
  description = "DNS names of the nodes."
  value       = [for node in module.seed : node.dns_name]
}