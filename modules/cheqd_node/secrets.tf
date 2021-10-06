# aws_secretsmanager
resource "aws_secretsmanager_secret" "node_key" {
    name             = "NODE_KEY"
    recovery_window_in_days = 0
}

 resource "aws_secretsmanager_secret_version" "node_key" {
   secret_id     = aws_secretsmanager_secret.node_key.id
   secret_string = var.node_key
 }

resource "aws_secretsmanager_secret" "genesis" {
    name             = "GENESIS"
    recovery_window_in_days = 0
}

 resource "aws_secretsmanager_secret_version" "genesis" {
   secret_id     = aws_secretsmanager_secret.genesis.id
   secret_string = var.genesis
 }


resource "aws_secretsmanager_secret" "priv_validator_key" {
    name             = "PRIV_VALIDATOR_KEY"
    recovery_window_in_days = 0
}

 resource "aws_secretsmanager_secret_version" "priv_validator_key" {
   secret_id     = aws_secretsmanager_secret.priv_validator_key.id
   secret_string = var.priv_validator_key
 }