resource "aws_sns_topic" "cpu_memory_topic" {
  name = "${var.moniker}_cpu_memory_topic"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.cpu_memory_topic.arn
  protocol  = "email"
  endpoint  = var.email_list
}