# Output variable definitions

output "dns_name" {
  description = "DNS name of the load balancer."
  value       = aws_lb.cheqd_node.dns_name
}
