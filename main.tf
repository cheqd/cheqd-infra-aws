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
  # seed
  pool_seed_moniker = "seed1-${substr("${var.region}", 0, 2)}"
  pool_seed_dns = "seed1.${substr("${var.region}", 0, 2)}.${var.domain_name}"

  # node
  pool_moniker = "node1-${substr("${var.region}", 0, 2)}"
  pool_dns = "node1.${substr("${var.region}", 0, 2)}.${var.domain_name}"

  nodes_count = 1

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
  moniker            = "${local.pool_moniker}"
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
  domain_name = "${local.pool_dns}"
  route53_zone = var.route53_zone

  genesis_arn = ""
  node_key_arn = ""
  priv_validator_key_arn = ""
}

#####
# Seed Node
#####
module "seed" {

  for_each = toset(formatlist("%s", range(local.nodes_count)))

  source   = "./modules/cheqd_seed_node"

  # VPC
  cidr_block = var.cidr_block

  vpc_id = module.node[0].cheqd_node_vpc_id
  public_subnet = module.node[0].cheqd_node_public_subnet_id
  public_subnet_2 = module.node[0].cheqd_node_public_subnet_2_id
  private_subnet = module.node[0].cheqd_node_private_subnet_id
  private_subnet_2 = module.node[0].cheqd_node_private_subnet_2_id

  # Node
  moniker            = "${local.pool_seed_moniker}"
  genesis_seed            = var.genesis_seed
  node_key_seed           = var.node_key_seed
  priv_validator_key_seed = var.priv_validator_key_seed
  
  
  # Node Args
  node_args          = "--rpc.laddr tcp://0.0.0.0:26657 --p2p.seed_mode true --p2p.persistent_peers <PEERS_FROM_CHECD_REPO> --minimum-gas-prices <MIN_GAS>"

  
  # Region
  availability_zone = "${var.region}b"
  region = var.region

  # Docker
  docker_image_url       = var.docker_image_url

  # Cloudwatch
  cloudwatch_log_region = var.region

  # Load balancer
  load_balancer_p2p_port = 26656
  load_balancer_rpc_port = 26657
  domain_name = "${local.pool_seed_dns}"
  route53_zone = var.route53_zone
  lb_logs_s3   = module.node[0].lb_logs_s3_bucket

  genesis_seed_arn = ""
  node_key_seed_arn = ""
  priv_validator_key_seed_arn = ""
}