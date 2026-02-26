variable "env_name" {
  description = "Environment name (e.g., production, develop)"
  type        = string
}

variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    zone = string
    cidr = string
  }))
}
