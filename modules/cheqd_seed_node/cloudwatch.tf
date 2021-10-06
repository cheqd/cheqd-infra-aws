#####
# Cloudwatch
#####

resource "aws_cloudwatch_log_group" "cheqd_node" {
  name              = "${var.env}-${var.moniker}"
  retention_in_days = 7
}
