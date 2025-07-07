# API Key secrets for Bedrock Access Gateway
resource "random_password" "bag_api_key" {
  length  = 10
  special = true
}

resource "aws_secretsmanager_secret" "bag_api_key_secret" {
  name_prefix = "bag-api-key-"
}

resource "aws_secretsmanager_secret_version" "bag_api_key_secret_version" {
  secret_id     = aws_secretsmanager_secret.bag_api_key_secret.id
  secret_string = random_password.bag_api_key.result
}

# API Key for MCPO
resource "random_password" "mcpo_api_key" {
  length  = 10
  special = true
}

resource "aws_secretsmanager_secret" "mcpo_api_key_secret" {
  name_prefix = "mcpo-api-key-"
}

resource "aws_secretsmanager_secret_version" "mcpo_api_key_secret_version" {
  secret_id     = aws_secretsmanager_secret.mcpo_api_key_secret.id
  secret_string = random_password.mcpo_api_key.result
}

# Other secrets
resource "aws_secretsmanager_secret" "gitlab_token_secret" {
  name_prefix = "gitlab-token-"
}

resource "aws_secretsmanager_secret" "linear_token_secret" {
  name_prefix = "linear-token-"
}