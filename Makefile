.PHONY: help init plan apply destroy clean
REGION=$(shell grep region terraform.tfvars | cut -d'=' -f2 | cut -d'"' -f2)
ACCOUNT_ID=$(shell grep account_id terraform.tfvars | cut -d'=' -f2 | cut -d'"' -f2)
PROFILE=$(shell grep profile terraform.tfvars | cut -d'=' -f2 | cut -d'"' -f2)

# Default target
help:
	@echo "Available targets:"
	@echo "  init        - Initialize Terraform"
	@echo "  plan        - Show Terraform plan"
	@echo "  apply       - Apply Terraform configuration"
	@echo "  destroy     - Destroy all resources"
	@echo "  clean       - Clean cloned repositories and Terraform state"
	@echo "  setup       - Complete setup (init + apply)"
	@echo "  setup-state - Setup of state management bucket"

# Initialize Terraform
init:
	@echo "Initializing Terraform..."
	@echo "[-] Using AWS Account ID: ${ACCOUNT_ID}"
	@echo "[-] Using AWS Region: ${REGION}"
	@echo "[-] Using AWS Profile: ${PROFILE}"
	terraform init --backend-config="region=${REGION}" --backend-config="bucket=${ACCOUNT_ID}-terraform-state" --backend-config="profile=${PROFILE}"

# Show what will be created/changed
plan:
	terraform plan

# Apply the configuration
apply:
	terraform apply --var-file=terraform.tfvars

# Destroy all resources
destroy:
	terraform destroy

# Clean up cloned repos and terraform state
clean:
	rm -rf containers/bedrock-access-gateway
	rm -rf containers/open-webui
	rm -rf .terraform
	rm -f .terraform.lock.hcl
	rm -f terraform.tfstate*

# Complete setup
setup: init apply
	@echo "Deployment complete! Get your URL with: cd terraform && terraform output url"

# Setup state management bucket
setup-state:
	@echo "Setting up state management bucket..."
	cd terraform_state && terraform init && terraform apply --var-file=../terraform.tfvars
	@echo "State management bucket setup complete!"

# Quick deploy (for when you've already configured terraform.tfvars)
deploy: setup

# Format Terraform files
fmt:
	terraform fmt -recursive