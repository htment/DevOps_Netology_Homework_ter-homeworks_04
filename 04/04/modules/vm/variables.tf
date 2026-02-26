variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "instance_name" {
  description = "Base name for instances"
  type        = string
  default     = "vm"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "instance_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "instance_memory" {
  description = "Memory in GB"
  type        = number
  default     = 2
}

variable "instance_core_fraction" {
  description = "Core fraction"
  type        = number
  default     = 20
}

variable "boot_disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "network-hdd"
}

variable "boot_disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 10
}

variable "image_family" {
  description = "Image family"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "network_id" {
  description = "Network ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "public_ip" {
  description = "Whether to assign public IP"
  type        = bool
  default     = true
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}

variable "cloud_init_path" {
  description = "Path to cloud-init file"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}
