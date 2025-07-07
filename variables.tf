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

variable "enable_vpc_endpoints" {
  description = "Enable VPC Endpoints"
  type        = bool
  default     = false
}

variable "openwebui_version" {
  description = "Version of OpenWebUI to use"
  type        = string
  default     = "v0.6.15"
}