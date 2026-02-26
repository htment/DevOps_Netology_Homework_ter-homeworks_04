# Переменные из personal.auto.tfvars
variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
}

variable "default_zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "service_account_key_file" {
  description = "Path to service account key file"
  type        = string
}

variable "public_key" {
  description = "Public SSH key for VM access"
  type        = string
  sensitive   = true
}

# Переменные из terraform.tfvars
variable "env_name" {
  description = "Environment name"
  type        = string
  default     = "develop"
}

variable "vpc_zone" {
  description = "Availability zone for VPC subnet"
  type        = string
  default     = "ru-central1-a"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "develop-vm"
}

# Переменные для VM модуля
variable "vm_cores" {
  description = "Number of CPU cores for VM"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Amount of memory in GB for VM"
  type        = number
  default     = 4
}

variable "vm_disk_size" {
  description = "Disk size in GB for VM"
  type        = number
  default     = 20
}