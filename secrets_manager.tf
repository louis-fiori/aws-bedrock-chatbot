# API Key secrets for Bedrock Access Gateway
resource "random_password" "bag_api_key" {
  length  = 32
  special = false
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
  length  = 32
  special = false
}

resource "aws_secretsmanager_secret" "mcpo_api_key_secret" {
  name_prefix = "mcpo-api-key-"
}

resource "aws_secretsmanager_secret_version" "mcpo_api_key_secret_version" {
  secret_id     = aws_secretsmanager_secret.mcpo_api_key_secret.id
  secret_string = random_password.mcpo_api_key.result
}

# Third-party tokens consumed by the MCPO MCP servers (GitLab, Linear).
# They are seeded with a placeholder so the MCPO task can start out of the box;
# replace the values in the AWS console / CLI with your real tokens.
# `ignore_changes` keeps Terraform from overwriting the value you set manually.
resource "aws_secretsmanager_secret" "gitlab_token_secret" {
  name_prefix = "gitlab-token-"
}

resource "aws_secretsmanager_secret_version" "gitlab_token_secret_version" {
  secret_id     = aws_secretsmanager_secret.gitlab_token_secret.id
  secret_string = "REPLACE_ME"

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_secretsmanager_secret" "linear_token_secret" {
  name_prefix = "linear-token-"
}

resource "aws_secretsmanager_secret_version" "linear_token_secret_version" {
  secret_id     = aws_secretsmanager_secret.linear_token_secret.id
  secret_string = "REPLACE_ME"

  lifecycle {
    ignore_changes = [secret_string]
  }
}
