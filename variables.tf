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