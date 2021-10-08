#####
# Cloudwatch
#####

resource "aws_cloudwatch_log_group" "cheqd_node" {
  name              = "${var.env}-${var.moniker}"
  retention_in_days = 7
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