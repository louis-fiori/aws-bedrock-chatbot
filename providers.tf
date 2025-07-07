terraform {
  required_version = "1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }

  backend "s3" {
    bucket       = "${var.account_id}-terraform-state"
    region       = var.region
    key          = "terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}
