#####
# VPC
#####

# taken from main node


#####
# ECS service
#####

resource "aws_security_group" "cheqd_node_ecs_service" {
  name        = "${var.moniker}_ecs_service"
  description = "Security group for cheqd node ecs service"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.moniker}_ecs_service"
  }
}

# Ingress from the LB

resource "aws_security_group_rule" "cheqd_node_ecs_service_p2p_ingress" {
  security_group_id = aws_security_group.cheqd_node_ecs_service.id
  type              = "ingress"
  from_port         = 26656
  to_port           = 26656
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_block] #"10.9.0.0/16"]
  ipv6_cidr_blocks  = ["::/0"]
}

# Ingress from the LB

resource "aws_security_group_rule" "cheqd_node_ecs_service_rpc_ingress" {
  security_group_id = aws_security_group.cheqd_node_ecs_service.id
  type              = "ingress"
  from_port         = 26657
  to_port           = 26657
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_block] #"10.9.0.0/16"]
  ipv6_cidr_blocks  = ["::/0"]
}

# Docker image pulling + access to other nodes

resource "aws_security_group_rule" "cheqd_node_ecs_service_all_egress" {
  security_group_id = aws_security_group.cheqd_node_ecs_service.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

# EFS egress

resource "aws_security_group_rule" "cheqd_node_ecs_service_nfs_egress" {
  security_group_id        = aws_security_group.cheqd_node_ecs_service.id
  type                     = "egress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.cheqd_node_efs.id
}

#####
# EFS cheqd_node security group
#####

resource "aws_security_group" "cheqd_node_efs" {
  name        = "${var.moniker}_efs"
  description = "Security group for cheqd_node efs service"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.moniker}_efs"
  }
}

# ECS service ingress

resource "aws_security_group_rule" "cheqd_node_nfs_ingress" {
  security_group_id        = aws_security_group.cheqd_node_efs.id
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.cheqd_node_ecs_service.id
}
