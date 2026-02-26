# variables.tf
variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "default_zone" {
  description = "Yandex Cloud default zone"
  type        = string
  default     = "ru-central1-a"
}

variable "service_account_key_file" {
  description = "Path to service account key file"
  type        = string
  default     = "~/.authorized_key.json"
}

variable "public_key" {
  description = "Public SSH key for accessing VMs"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}




# variable "subnet_id" {
#   description = "Subnet ID for VMs"
#   type        = string
#   # Значение будет получено из ресурса yandex_vpc_subnet.develop_a.id
# }

variable "image_family" {
  description = "Image family for VMs"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "boot_disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 10
}

variable "boot_disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "network-hdd"
}


variable "vpc_cidr" {
  description = "CIDR block for subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "vpc_zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}


variable "env_name" {
  description = "Environment name (develop/production)"
  type        = string
}

# Переменные для провайдера (если еще не определены)
variable "token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

# variable "cloud_id" {
#   description = "Yandex Cloud ID"
#   type        = string
# }

# variable "folder_id" {
#   description = "Yandex Folder ID"
#   type        = string
# }
