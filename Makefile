.PHONY: help init plan apply destroy clean

# Default target
help:
	@echo "Available targets:"
	@echo "  init     - Initialize Terraform"
	@echo "  plan     - Show Terraform plan"
	@echo "  apply    - Apply Terraform configuration"
	@echo "  destroy  - Destroy all resources"
	@echo "  clean    - Clean cloned repositories and Terraform state"
	@echo "  setup    - Complete setup (init + apply)"

# Initialize Terraform
init:
	terraform init

# Show what will be created/changed
plan:
	terraform plan

# Apply the configuration
apply:
	terraform apply

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

# Quick deploy (for when you've already configured terraform.tfvars)
deploy: setup