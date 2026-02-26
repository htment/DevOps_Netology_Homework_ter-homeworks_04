variable "env_name" {
  description = "Environment name (used for resource naming)"
  type        = string
}

variable "zone" {
  description = "Availability zone for subnet"
  type        = string
}

variable "cidr" {
  description = "CIDR block for subnet"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = ""  # Если не указано, будет сформировано из env_name
}


variable "service_account_key_file" {
  description = "Path to service account key file"
  type        = string
  default     = "~/.authorized_key.json"
}