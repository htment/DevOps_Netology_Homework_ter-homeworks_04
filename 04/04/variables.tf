variable "boot_disk_type" {
  description = "Boot disk type for VMs"
  type        = string
  default     = "network-hdd"
}

variable "boot_disk_size" {
  description = "Boot disk size for VMs in GB"
  type        = number
  default     = 10
}

variable "image_family" {
  description = "Image family for VMs"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}







# variables.tf - добавьте эти переменные
variable "vpc_zone" {
  description = "Availability zone for VPC"
  type        = string
  default     = "ru-central1-a"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "default_zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}