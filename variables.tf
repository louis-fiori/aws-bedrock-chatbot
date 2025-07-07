variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-1"
}

variable "profile" {
  description = "AWS Profile"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = null
}

variable "feature_toggles" {
  description = "Enable VPC Endpoints"

  type = object({
    enable_vpc_endpoints = bool
    enable_domain        = bool
  })

  default = {
    enable_vpc_endpoints = false
    enable_domain        = false
  }
}

variable "versions" {
  description = "Version of OpenWebUI to use"

  type = object({
    openwebui              = string
    bedrock_access_gateway = string
  })

  default = {
    openwebui              = "v0.6.15"
    bedrock_access_gateway = "76a3614f1768e6f0ce161bdd7940dfcb6b16e9b0"
  }
}