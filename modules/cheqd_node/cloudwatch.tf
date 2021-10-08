#####
# Cloudwatch
#####

resource "aws_cloudwatch_log_group" "cheqd_node" {
  name              = "${var.moniker}"
  retention_in_days = 7
}

# VPC Flow Logs

resource "aws_flow_log" "cheqd_node_vpc" {
  iam_role_arn    = aws_iam_role.cheqd_node_vpc.arn
  log_destination = aws_cloudwatch_log_group.cheqd_node_vpc.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.cheqd_node.id
}

resource "aws_cloudwatch_log_group" "cheqd_node_vpc" {
  name = "${var.moniker}_vpc"
}

resource "aws_iam_role" "cheqd_node_vpc" {
  name = "${var.moniker}_vpc"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cheqd_node_vpc" {
  name = "${var.moniker}_vpc"
  role = aws_iam_role.cheqd_node_vpc.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}