variable "env" {
  default = "test"
}

variable "cidr_block" {
  default = "10.9.0.0/16"
}

variable "region" {
  default = "us-east-1"
}

variable "projectname" {
  default = "cheqd"
}

variable "genesis" {
  default = "arn:aws:secretsmanager:us-east-1:613050746026:secret:GENESIS_TEST-H0ktie"
}

variable "node_key" {
  default = "arn:aws:secretsmanager:us-east-1:613050746026:secret:NODE_KEY_TEST-iCCEUg"
}

variable "priv_validator_key" {
  default = "arn:aws:secretsmanager:us-east-1:613050746026:secret:PRIV_VALIDATOR_KEY_TEST-7GBkyX"
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

#Docker

variable "docker_image_url" {
  default = "ghcr.io/cheqd/cheqd-node:v0.1.16"
}