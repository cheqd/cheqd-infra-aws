terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.48.0"
      
    }
  }
  
  required_version = ">= 1.0.1"
}

provider "aws" {
  region  = "${var.region}"
}

#####
# Global params
#####

locals {
  pool_moniker = "net"

  nodes_count = 1

  node0_id = trim(file("node_configs/node0/node_id.txt"), " \n")
}

#####
# Node
#####

module "node" {
  for_each = toset(formatlist("%s", range(local.nodes_count)))
  source   = "./modules/cheqd_node"

  # Node
  moniker            = "${local.pool_moniker}-node-${each.value}"
  genesis            = filebase64("node_configs/node${each.value}/config/genesis.json")
  node_key           = filebase64("node_configs/node${each.value}/config/node_key.json")
  priv_validator_key = filebase64("node_configs/node${each.value}/config/priv_validator_key.json")
  node_args          = "--rpc.laddr tcp://0.0.0.0:26657 --p2p.persistent_peers ${local.node0_id}@${module.node[0].dns_name}:26656"

  # Region
  availability_zone = "${var.region}a"
  region = var.region

  # Docker
  docker_image_url       = "ghcr.io/cheqd/cheqd-node:v0.1.12"
  docker_auth_secret_arn = "arn:aws:secretsmanager:eu-west-1:613050746026:secret:verim_gcr-XUfx0l"

  # Cloudwatch
  cloudwatch_log_region = var.region #"eu-west-1"

  # Load balancer
  load_balancer_p2p_port = 26656
  load_balancer_rpc_port = 26657
}

