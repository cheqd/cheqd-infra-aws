#####
# Load balancer
#####

resource "aws_lb" "cheqd_node" {
  name               = "${var.moniker}-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.public_cheqd_node.id, aws_subnet.public_cheqd_node_2.id]
  
  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "${var.moniker}"
    enabled = true
  }
}

resource "aws_s3_bucket" "lb_logs" {
    bucket            = "nlb-${var.moniker}-logs"

    policy =<<EOF
{
"Id": "AddPutPolicy",
"Version": "2012-10-17",
"Statement": [
          {
          "Sid":"AllowPut",
          "Action": "s3:PutObject",
          "Effect": "Allow",
          "Resource": "arn:aws:s3:::nlb-${var.moniker}-logs/*",
          "Principal": "*"
          }
]
}
EOF
    
    lifecycle_rule {
      id      = "log"
      enabled = true
      expiration {
        days = 90
      }
    }
    versioning {
        enabled    = false
        mfa_delete = false
    }
}


# RPC

resource "aws_lb_target_group" "cheqd_node_rpc" {
  name        = "${var.moniker}-rpc-tg" # Random suffix is required by `create_before_destroy` property
  target_type = "ip"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.cheqd_node.id
 

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

# resource "aws_lb_listener_rule" "ecs-listener-rule" {
#   listener_arn = aws_lb_listener.cheqd_node_rpc.arn 
#   priority     = 98

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.cheqd_node_rpc.arn
#   }

#   condition {
#     host_header {
#       values = ["${var.domain_name}"] # rule forwards the request to a specific target group based on the DNS record
#     }
#   }
# }

# P2P
resource "aws_lb_target_group" "cheqd_node_p2p" {
  name        = "${var.moniker}-p2p-tg" # Random suffix is required by create_before_destroy
  target_type = "ip"
  port        = 80 #var.load_balancer_p2p_port
  protocol    = "TCP"
  vpc_id      = aws_vpc.cheqd_node.id

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

