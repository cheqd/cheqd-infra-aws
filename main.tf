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

  # Node
  moniker            = "${local.pool_moniker}-node-${each.value}"
  genesis            = var.genesis
  node_key           = var.node_key
  priv_validator_key = var.priv_validator_key
  node_args          = "--rpc.laddr tcp://0.0.0.0:26657 --p2p.persistent_peers f5a982ab634c5c14cd3651e69971244721f7726b@nodes.testnet.cheqd.network:26656,ba1689516f45be7f79c7450394144711e02e7341@3.13.19.41:26656,eee1df840fe4e55738efb7e6e2cf6af83712f718@65.21.254.210:26656,20efd9ed60e9e7ed3a75e213773afc8d9285f5a3@13.244.78.24:26656"

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
}

