#####
# ECS cluster
#####

resource "aws_ecs_cluster" "cheqd_node" {
  name               = "${var.env}_${var.moniker}_cluster_tf"
  capacity_providers = ["FARGATE"]

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

#####
# ECS service
#####

resource "aws_ecs_service" "cheqd_node" {
  name                   = "${var.env}_${var.moniker}_service_tf"
  cluster                = aws_ecs_cluster.cheqd_node.id
  desired_count          = 1
  task_definition        = aws_ecs_task_definition.cheqd_node.arn
  launch_type            = "FARGATE"
  enable_execute_command = true

  network_configuration {
    subnets          = [aws_subnet.cheqd_node.id]
    security_groups  = [aws_security_group.cheqd_node_ecs_service.id]
    assign_public_ip = true # TODO: Get rid of this. Workaround for docker image pulling.
  }

  # RPC endpoint
  load_balancer {
    target_group_arn = aws_lb_target_group.cheqd_node_rpc.arn
    container_name   = "cheqd_node"
    container_port   = local.container_rpc_port
  }

  # P2P endpoint
  load_balancer {
    target_group_arn = aws_lb_target_group.cheqd_node_p2p.arn
    container_name   = "cheqd_node"
    container_port   = local.container_p2p_port
  }

  depends_on = [
    aws_efs_mount_target.cheqd_node # It takes time to propagate DNS names
  ]
}

#####
# ECS task definition
#####

resource "aws_ecs_task_definition" "cheqd_node" {
  family                   = "${var.env}_${var.moniker}_task_def_tf"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024                                                # 1vCPU
  memory                   = 2048                                                # 2GB
  execution_role_arn       = aws_iam_role.cheqd_node_ecs_task_execution_role.arn # Required to access docker auth secret, logs
  task_role_arn            = aws_iam_role.cheqd_node_ecs_task_role.arn           # EFS access

  container_definitions = jsonencode([
    {
      name  = "cheqd_node"
      image = var.docker_image_url
      repositoryCredentials = {
        credentialsParameter = var.docker_auth_secret_arn
      }
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group : aws_cloudwatch_log_group.cheqd_node.id
          awslogs-region : var.cloudwatch_log_region
          awslogs-stream-prefix : var.moniker
        }
      }
      entryPoint = [
        "node-runner"
      ]
      portMappings = [
        {
          containerPort = local.container_p2p_port # P2P port
        },
        {
          containerPort = local.container_rpc_port # RPC port
        }
      ]
      environment = [
        {
          name  = "NODE_MONIKER"
          value = "${var.env}-${var.moniker}"
        },
        {
          name  = "GENESIS"
          value = "${var.genesis}"
        },
        {
          name  = "NODE_KEY"
          value = "${var.node_key}"
        },
        {
          name  = "PRIV_VALIDATOR_KEY"
          value = "${var.priv_validator_key}"
        },
        {
          name  = "NODE_ARGS"
          value = "${var.node_args}"
        }
      ]
      mountPoints = [
        {
          containerPath = "/home/cheqd/.cheqdnode"
          sourceVolume  = "${var.env}_${var.moniker}_volume"
        }
      ]
    }
  ])

  volume {
    name = "${var.env}_${var.moniker}_volume"

    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.cheqd_node.id
      transit_encryption = "ENABLED" # Required for the mount point

      authorization_config {
        access_point_id = aws_efs_access_point.cheqd_node.id
        iam             = "ENABLED" # Required for transit encryption
      }
    }
  }
}
