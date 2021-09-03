###
# Input variable definitions
###

# Node

variable "moniker" {
  description = "Moniker of the node."
  type        = string
}

variable "genesis" {
  description = "Base64 encoded genesis.json file."
  type        = string
}

variable "node_key" {
  description = "Base64 encoded node_key.json file."
  type        = string
}

variable "priv_validator_key" {
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

variable "docker_auth_secret_arn" {
  description = "Secret arn to use to pull the node image."
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
  default = "10.9.0.0/16"
}



