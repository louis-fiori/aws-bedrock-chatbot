terraform {
  required_version = "1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}
