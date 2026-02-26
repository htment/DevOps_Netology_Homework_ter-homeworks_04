variable "env_name" {
  description = "Name of the environment (e.g., develop, production)"
  type        = string
}

variable "subnets" {
  description = "List of subnets with zones and CIDR blocks"
  type = list(object({
    zone = string
    cidr = string
  }))
}