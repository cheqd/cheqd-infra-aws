#####
# IAM roles
#####

#####
# ECS task execution role
#####

resource "aws_iam_role" "cheqd_node_ecs_task_execution_role" {
  name = "${var.env}_${var.moniker}_${var.region}_ecs_task_execution_role_tf"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "cheqd_node_docker_auth_secret_access" {
  name = "cheqd_node_docker_auth_secret_access"
  role = aws_iam_role.cheqd_node_ecs_task_execution_role.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement = [
      {
        Effect : "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = [
          var.node_key,
          var.priv_validator_key,
          var.genesis
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy" "cloudwatch_access" {
  name = "${var.env}_${var.moniker}_${var.region}_cloudwatch_access"
  role = aws_iam_role.cheqd_node_ecs_task_execution_role.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement = [
      {
        Effect : "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

#####
# ECS task role
#####

resource "aws_iam_role" "cheqd_node_ecs_task_role" {
  name = "${var.env}_${var.moniker}_${var.region}_ecs_task_role_tf"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "efs_access" {
  name = "${var.env}_${var.moniker}_${var.region}_efs_access"
  role = aws_iam_role.cheqd_node_ecs_task_role.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement = [
      {
        Effect : "Allow",
        Action = [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientRootAccess"
        ],
        Resource = aws_efs_file_system.cheqd_node.arn
      }
    ]
  })
}

resource "aws_iam_role_policy" "allow_execute_command" {
  name = "${var.env}_${var.moniker}_${var.region}_allow_execute_command"
  role = aws_iam_role.cheqd_node_ecs_task_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        Resource = "*"
      }
    ]
  })
}