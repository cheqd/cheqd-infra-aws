variable "env" {
  default = "test"
}

variable "cidr_block" {
  default = "10.9.0.0/16"
}

variable "region" {
  default = "eu-west-1"
}

variable "projectname" {
  default = "cheqd"
}

variable "genesis" {
  default = "ARN:GENESIS_TEST" # example arn:secretsmanager:Region:AccountId:secret:tutorials/MyFirstSecret-jiObOV
}

variable "node_key" {
  default = "ARN:NODE_KEY_TEST" # example arn:secretsmanager:Region:AccountId:secret:tutorials/MyFirstSecret-jiObOV
}

variable "priv_validator_key" {
  default = "ARN:PRIV_VALIDATOR_KEY_TEST" # example arn:secretsmanager:Region:AccountId:secret:tutorials/MyFirstSecret-jiObOV
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
