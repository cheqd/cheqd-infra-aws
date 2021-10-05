# aws_secretsmanager_secret.NODE_KEY:
resource "aws_secretsmanager_secret" "node_key_seed" {
    name             = "NODE_KEY_SEED"
    recovery_window_in_days = 0
}

 resource "aws_secretsmanager_secret_version" "node_key_seed" {
   secret_id     = aws_secretsmanager_secret.node_key_seed.id
   secret_string = var.node_key_seed
 }

resource "aws_secretsmanager_secret" "genesis_seed" {
    name             = "GENESIS_SEED"
    recovery_window_in_days = 0
}

 resource "aws_secretsmanager_secret_version" "genesis_seed" {
   secret_id     = aws_secretsmanager_secret.genesis_seed.id
   secret_string = var.genesis_seed
 }


resource "aws_secretsmanager_secret" "priv_validator_key_seed" {
    name             = "PRIV_VALIDATOR_KEY_SEED"
    recovery_window_in_days = 0
}

 resource "aws_secretsmanager_secret_version" "priv_validator_key_seed" {
   secret_id     = aws_secretsmanager_secret.priv_validator_key_seed.id
   secret_string = var.priv_validator_key_seed
 }