###
# Input variable definitions
###

# Node

variable "moniker" {
  description = "Moniker of the node."
  type        = string
}

variable "genesis_seed" {
  description = "Base64 encoded genesis.json file."
  type        = string
}

variable "node_key_seed" {
  description = "Base64 encoded node_key.json file."
  type        = string
}

variable "priv_validator_key_seed" {
  description = "Base64 encoded priv_validator_key.json file."
  type        = string
}

variable "node_args" {
  description = "Additional arguments to pass to the node."
  type        = string
}

# Zones

variable "availability_zone" {
  description = "Availability zone to deploy node infrastructure."
  type        = string
}

# Docker

variable "docker_image_url" {
  description = "URL of the node docker image."
  type        = string
}

# Cloudwatch

variable "cloudwatch_log_region" {
  description = "Cloudwatch log region."
  type        = string
}

# Load balancer

variable "load_balancer_p2p_port" {
  description = "p2p to expose through LB."
  type        = string
}

variable "load_balancer_rpc_port" {
  description = "rpc to expose through LB."
  type        = string
}

variable "env" {
  default = "test"
}

variable "cidr_block" {
  description = "cidr block for vpc and subnets"
}


variable "domain_name" {
  description = "Domain name (DNS)."
  type        = string
}

variable "route53_zone" {
  description = "Zone for the route53 records."
  type        = string
}

variable "email_list" {
  description = "List of emails."
}
