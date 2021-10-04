#####
# Terraform version
#####
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

  #node0_id = trim(file("node_configs/node0/node_id.txt"), " \n")
}

#####
# Node
#####

module "node" {
  for_each = toset(formatlist("%s", range(local.nodes_count)))
  source   = "./modules/cheqd_node"

  # VPC
  cidr_block = var.cidr_block

  # Node
  moniker            = "${local.pool_moniker}-node-${each.value}"
  genesis            = var.genesis
  node_key           = var.node_key
  priv_validator_key = var.priv_validator_key
  node_args          = "--rpc.laddr tcp://0.0.0.0:26657 --p2p.persistent_peers <PEERS_FROM_CHECD_REPO>" # <PEERS_FROM_CHECD_REPO> - Peers need to be copied from https://github.com/cheqd/cheqd-node/blob/main/persistent_chains/testnet/persistent_peers.txt

  # Region
  availability_zone = "${var.region}a"
  region = var.region

  # Docker
  docker_image_url       = var.docker_image_url

  # Cloudwatch
  cloudwatch_log_region = var.region 

  # Load balancer
  load_balancer_p2p_port = 26656
  load_balancer_rpc_port = 26657

  genesis_arn = ""
  node_key_arn = ""
  priv_validator_key_arn = ""
}

