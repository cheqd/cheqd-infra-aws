variable "env" {
  default = "test"
}

variable "region" {
  type = string
  description = "Enter a Region"
}

variable "projectname" {
  default = "cheqd"
}

variable "genesis" {
  type = string
  description = "Enter a Genesis value."
}

variable "node_key" {
  type = string
  description = "Enter a Node Key value."
}

variable "priv_validator_key" {
  type = string
  description = "Enter a Priv Validator Key value."
}

# Tags Array ( referenced as ${var.tags["tagname"]} )
variable "tags" {
  type = map

  default = {
    Name        = "cheqd"
    projectname = "cheqd"
    act         = "test"
    costcentre  = ""
    env         = "test"
    repository  = "GH_REPO_URL"
    script      = "Terraform"
    service     = "cheqd-app"
    vpc         = "main"
  }
}

variable "cidr_block" {
  type = string
  description = "Enter a cidr block. Example 10.9.0.0/16"
}

#Docker
variable "docker_image_url" {
  default = "ghcr.io/cheqd/cheqd-node:v0.2.2"
}
