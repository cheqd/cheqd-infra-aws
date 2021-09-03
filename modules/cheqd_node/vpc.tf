#####
# VPC
#####

resource "aws_vpc" "cheqd_node" {
  cidr_block           = "10.9.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}_${var.moniker}_vpc"
  }
}

#####
# Subnets
#####

# Private

resource "aws_subnet" "cheqd_node" {
  vpc_id            = aws_vpc.cheqd_node.id
  availability_zone = var.availability_zone
  cidr_block        = "${cidrsubnet(var.cidr_block, 6, 2)}" #"10.9.0.0/24"
   map_public_ip_on_launch = false

  tags = {
    Name = "${var.env}_${var.moniker}_private_subnet_1"
  }
}

resource "aws_subnet" "cheqd_node_2" {
  vpc_id            = aws_vpc.cheqd_node.id
  availability_zone = var.availability_zone
  cidr_block        = "${cidrsubnet(var.cidr_block, 6, 3)}" 
   map_public_ip_on_launch = false

  tags = {
    Name = "${var.env}_${var.moniker}_private_subnet_2"
  }
}

# IG
resource "aws_internet_gateway" "cheqd_node" {
  vpc_id = aws_vpc.cheqd_node.id

  tags = {
    Name = "${var.env}_${var.moniker}_gateway"
  }
}

# RT IG
resource "aws_default_route_table" "cheqd_node" {
  default_route_table_id = aws_vpc.cheqd_node.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cheqd_node.id
    
  }

  tags = {
    Name = "${var.env}_${var.moniker}_route_table"
  }
}

# Public
resource "aws_subnet" "public_cheqd_node" {
  vpc_id            = aws_vpc.cheqd_node.id
  availability_zone = var.availability_zone
  cidr_block        = "${cidrsubnet(var.cidr_block, 6, 0)}" 
   map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}_${var.moniker}_public_subnet_1"
  }
}

resource "aws_subnet" "public_cheqd_node_2" {
  vpc_id            = aws_vpc.cheqd_node.id
  availability_zone = var.availability_zone
  cidr_block        = "${cidrsubnet(var.cidr_block, 6, 1)}" 
   map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}_${var.moniker}_public_subnet_2"
  }
}

resource "aws_eip" "nat_eip" {
  count = 1
  vpc   = true
}

resource "aws_nat_gateway" "private" {
  count = 1 # number of NAT GWs to be created

  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = aws_subnet.public_cheqd_node.id

  tags = {
    Name       = "nat-${var.env}-${var.moniker}-private"
    Function   = "route table"
  }
}


#####
# ECS service
#####

resource "aws_security_group" "cheqd_node_ecs_service" {
  name        = "${var.moniker}_ecs_service"
  description = "Security group for cheqd node ecs service"
  vpc_id      = aws_vpc.cheqd_node.id

  tags = {
    Name = "${var.env}_${var.moniker}_ecs_service"
  }
}

# Ingress from the LB

resource "aws_security_group_rule" "cheqd_node_ecs_service_p2p_ingress" {
  security_group_id = aws_security_group.cheqd_node_ecs_service.id
  type              = "ingress"
  from_port         = 26656
  to_port           = 26656
  protocol          = "tcp"
  cidr_blocks       = ["10.9.0.0/16"]
  ipv6_cidr_blocks  = ["::/0"]
}

# Ingress from the LB

resource "aws_security_group_rule" "cheqd_node_ecs_service_rpc_ingress" {
  security_group_id = aws_security_group.cheqd_node_ecs_service.id
  type              = "ingress"
  from_port         = 26657
  to_port           = 26657
  protocol          = "tcp"
  cidr_blocks       = ["10.9.0.0/16"]
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
  vpc_id      = aws_vpc.cheqd_node.id

  tags = {
    Name = "${var.env}_${var.moniker}_efs"
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
