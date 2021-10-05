#####
# IAM roles
#####

#####
# ECS task execution role
#####

resource "aws_iam_role" "cheqd_node_ecs_task_execution_role" {
  name = "${var.moniker}_ecs_task_execution_role_tf"

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
          aws_secretsmanager_secret.node_key_seed.arn,
          aws_secretsmanager_secret.priv_validator_key_seed.arn,
          aws_secretsmanager_secret.genesis_seed.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy" "cloudwatch_access" {
  name = "${var.moniker}_cloudwatch_access"
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
  name = "${var.moniker}_ecs_task_role_tf"

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
  name = "${var.moniker}_efs_access"
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
  name = "${var.moniker}_allow_execute_command"
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
