variable "env" {
  default = "new"
}

variable "projectname" {
  default = "cheqd"
}

# Tags Array ( referenced as ${var.tags["tagname"]} )
variable "tags" {
  type = map

  default = {
    Name        = "cheqd"
    projectname = "cheqd"
    act         = "new"
    costcentre  = ""
    env         = "new"
    repository  = "GH_REPO_URL"
    script      = "Terraform"
    service     = "cheqd-app"
    vpc         = "main"
  }
}
variable "genesis" {
  type = string
  description = "Enter a Genesis."
}

variable "node_key" {
  type = string
  description = "Enter a Node Key."
}

variable "priv_validator_key" {
  type = string
  description = "Enter a Priv Validator Key."
}

variable "genesis_seed" {
  type = string
  description = "Enter a Genesis."
}

variable "node_key_seed" {
  type = string
  description = "Enter a Node Key."
}

variable "priv_validator_key_seed" {
  type = string
  description = "Enter a Priv Validator Key."
}

variable "region" {
  type = string
  description = "Enter a Region"
}

variable "domain_name" {
  default = "testnet.cheqd.network"
}

variable "route53_zone" {
  default = "cheqd.network"
}

variable "cidr_block" {
  type = string
  description = "Enter a cidr block. Example 10.9.0.0/16"
}

#Docker
variable "docker_image_url" {
  default = "ghcr.io/cheqd/cheqd-node:v0.2.2"
}