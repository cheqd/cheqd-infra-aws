variable "env" {
  default = "test"
}

variable "cidr_block" {
  default = "10.9.0.0/16"
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
  description = "Enter a Genesis ARN variable. Example arn:secretsmanager:Region:AccountId:secret:tutorials/MyFirstSecret-jiObOV"
}

variable "node_key" {
  type = string
  description = "Enter a Node Key ARN variable. Example arn:secretsmanager:Region:AccountId:secret:tutorials/MyFirstSecret-jiObOV"
}

variable "priv_validator_key" {
  type = string
  description = "Enter a Priv Validator Key ARN variable. Example arn:secretsmanager:Region:AccountId:secret:tutorials/MyFirstSecret-jiObOV"
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
