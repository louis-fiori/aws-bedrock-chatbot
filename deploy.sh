#!/usr/bin/env bash
#
# One-shot deployment helper.
#
# It bootstraps the remote state bucket, initializes the backend and applies
# the infrastructure. The Terraform configuration itself clones the
# Open WebUI / Bedrock Access Gateway sources and builds the container images
# (see git_repositories.tf / ecr.tf), so no manual cloning is needed here.
set -euo pipefail

cd "$(dirname "$0")"

if [ ! -f terraform.tfvars ]; then
  echo "Error: terraform.tfvars not found."
  echo "Copy terraform.tfvars.example to terraform.tfvars and fill in your values first."
  exit 1
fi

# 1. Create the S3 bucket that stores the remote Terraform state (idempotent).
make setup-state

# 2. Initialize the backend and apply the main configuration.
make init
make apply

echo
echo "Deployment complete! Get your URL with: terraform output url"
