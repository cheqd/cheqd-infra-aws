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

resource "aws_cloudwatch_metric_alarm" "CPUUtilization_alarm" {
  alarm_name                = "${var.moniker}-cpu-utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "85"
  alarm_description         = "This metric monitors ECS CPU utilization for ${var.moniker}"
  alarm_actions             =  [aws_sns_topic.cpu_memory_topic.arn]
  ok_actions                =  [aws_sns_topic.cpu_memory_topic.arn]
  insufficient_data_actions = []
  treat_missing_data        = "notBreaching"
  dimensions = {
    ClusterName = "${aws_ecs_cluster.cheqd_node.name}"
    ServiceName = "${aws_ecs_service.cheqd_node.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "MemoryUtilization_alarm" {
  alarm_name                = "${var.moniker}-memory"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "70"
  alarm_description         = "This metric monitors ECS memory utilization for ${var.moniker}"
  alarm_actions             = [aws_sns_topic.cpu_memory_topic.arn]
  ok_actions                = [aws_sns_topic.cpu_memory_topic.arn]
  insufficient_data_actions = []
  treat_missing_data        = "notBreaching"
  dimensions = {
    ClusterName = "${aws_ecs_cluster.cheqd_node.name}"
    ServiceName = "${aws_ecs_service.cheqd_node.name}"
  }
}