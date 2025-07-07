variable "name" {
  description = "Name of the security group"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cidr_ingresses" {
  description = "List of ingress rules to allow from CIDR blocks"
  type = list(object({
    cidr_blocks = list(string)
    port        = number
    protocol    = string
  }))
  default = []
}

variable "security_group_ingresses" {
  description = "List of ingress rules to allow from other security groups"
  type = list(object({
    security_groups = list(string)
    port            = number
    protocol        = string
  }))
  default = []
}

variable "cidr_egresses" {
  description = "List of egress rules to allow to CIDR blocks"
  type = list(object({
    cidr_blocks = list(string)
    port        = number
    protocol    = string
  }))

  default = [{
    cidr_blocks = ["0.0.0.0/0"]
    port        = 0
    protocol    = "-1"
  }]
}
