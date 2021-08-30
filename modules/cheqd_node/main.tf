#####
# Providers
#####

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.48.0"
    }
  }
}

#####
# Locals
#####

locals {
  container_uid      = 1000
  container_gid      = 1000
  container_p2p_port = 26656
  container_rpc_port = 26657

}
