#####
# Load balancer
#####

resource "aws_lb" "cheqd_node" {
  name               = "${var.moniker}-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [var.public_subnet, var.public_subnet_2]
}

# RPC

resource "aws_lb_target_group" "cheqd_node_rpc" {
  name        = "${var.moniker}-rpc-tg" # Random suffix is required by `create_before_destroy` property
  target_type = "ip"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
 

  lifecycle { # Is required to prevent `Error deleting Target Group: ResourceInUse`
    create_before_destroy = true
    ignore_changes        = [name]
  }

   health_check {
    protocol = "TCP"
  }

}

# TLS 
resource "aws_lb_listener" "cheqd_node_rpc" {
  load_balancer_arn = aws_lb.cheqd_node.arn
  port              = var.load_balancer_rpc_port
  protocol          = "TCP"
  #certificate_arn   = aws_acm_certificate.testnet_cheqd_network_cert.arn
  #alpn_policy       = "HTTP2Preferred"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cheqd_node_rpc.arn
  }
}
# P2P
resource "aws_lb_target_group" "cheqd_node_p2p" {
  name        = "${var.moniker}-p2p-tg" # Random suffix is required by create_before_destroy
  target_type = "ip"
  port        = 80 #var.load_balancer_p2p_port
  protocol    = "TCP"
  vpc_id      = var.vpc_id

  lifecycle { # Is required to prevent `Error deleting Target Group: ResourceInUse`
    create_before_destroy = true
    ignore_changes        = [name]
  }
}

resource "aws_lb_listener" "cheqd_node_p2p" {
  load_balancer_arn = aws_lb.cheqd_node.arn
  port              = var.load_balancer_p2p_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cheqd_node_p2p.arn
  }
}

