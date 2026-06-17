terraform {
  # >= 1.10 is required for the native S3 state lock (use_lockfile).
  required_version = ">= 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.52"
    }
  }

  backend "s3" {
    key          = "terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}
