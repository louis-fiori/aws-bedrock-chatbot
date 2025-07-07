variable "name" {
  description = "The name of the role"
  type        = string
  default     = null
}

variable "service" {
  description = "The target service that will assume the role"
  type        = list(string)
  default     = null
}

variable "managed_policy_arns" {
  description = "The list of managed policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}
