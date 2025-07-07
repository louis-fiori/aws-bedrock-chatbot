variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc" {
  description = "VPC configuration"
  type = object({
    id         = string
    cidr       = string
    subnet_ids = list(string)
  })
}

variable "vpc_interface_endpoints" {
  description = "List of VPC interface endpoints"
  type = list(object({
    name   = string
    policy = optional(string)
  }))
}