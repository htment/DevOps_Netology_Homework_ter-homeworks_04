#!/bin/bash

# Скрипт для создания структуры проекта по Заданию 1
# Использует сервисный аккаунт для аутентификации
# Запустите: chmod +x setup.sh && ./setup.sh

set -e

echo "🚀 Создание структуры проекта для Задания 1..."

# Создаем директорию проекта
mkdir -p 04/src
cd 04/src

echo "📁 Созданы директории: 04/src"

# Создаем providers.tf
cat > providers.tf << 'PROVIDERS_EOF'
# providers.tf
terraform {
  required_version = ">=1.12.0"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.130"
    }
    template = {
      source = "hashicorp/template"
      version = "~> 2.2"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
PROVIDERS_EOF
echo "✅ Создан providers.tf"

# Создаем variables.tf
cat > variables.tf << 'VARIABLES_EOF'
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
}

variable "subnet_id" {
  description = "Subnet ID for VMs"
  type        = string
}

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
VARIABLES_EOF
echo "✅ Создан variables.tf"

# Создаем main.tf
cat > main.tf << 'MAIN_EOF'
# main.tf
data "yandex_vpc_subnet" "selected" {
  subnet_id = var.subnet_id
}

module "marketing_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  env_name       = "marketing"
  network_id     = data.yandex_vpc_subnet.selected.network_id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [var.subnet_id]
  
  instance_name  = "marketing-vm"
  instance_count = 1
  instance_cores         = 2
  instance_memory        = 2
  instance_core_fraction = 20
  boot_disk_type = var.boot_disk_type
  boot_disk_size = var.boot_disk_size
  public_ip = true
  image_family = var.image_family
  preemptible = true
  
  labels = {
    project     = "marketing"
    environment = "production"
    created_by  = "terraform"
  }
  
  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml", {
      ssh_public_key = var.public_key
    })
  }
}

module "analytics_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  env_name       = "analytics"
  network_id     = data.yandex_vpc_subnet.selected.network_id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [var.subnet_id]
  
  instance_name  = "analytics-vm"
  instance_count = 1
  instance_cores         = 2
  instance_memory        = 4
  instance_core_fraction = 20
  boot_disk_type = var.boot_disk_type
  boot_disk_size = var.boot_disk_size
  public_ip = true
  image_family = var.image_family
  preemptible = true
  
  labels = {
    project         = "analytics"
    environment     = "production"
    created_by      = "terraform"
    data_processing = "true"
  }
  
  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml", {
      ssh_public_key = var.public_key
    })
  }
}
MAIN_EOF
echo "✅ Создан main.tf"

# Создаем outputs.tf
cat > outputs.tf << 'OUTPUTS_EOF'
# outputs.tf
output "marketing_vm_info" {
  value = {
    name         = module.marketing_vm.instance_name
    external_ip  = module.marketing_vm.external_ip
    internal_ip  = module.marketing_vm.internal_ip
    labels       = module.marketing_vm.labels
    id           = module.marketing_vm.instance_id
  }
}

output "analytics_vm_info" {
  value = {
    name         = module.analytics_vm.instance_name
    external_ip  = module.analytics_vm.external_ip
    internal_ip  = module.analytics_vm.internal_ip
    labels       = module.analytics_vm.labels
    id           = module.analytics_vm.instance_id
  }
}

output "connect_instructions" {
  value = <<-EOT
    Для подключения к ВМ маркетинга:
    ssh ubuntu@${module.marketing_vm.external_ip}
    
    Для подключения к ВМ аналитики:
    ssh ubuntu@${module.analytics_vm.external_ip}
    
    После подключения проверьте nginx:
    sudo nginx -t
    curl localhost
  EOT
}

output "module_marketing_vm" {
  value = module.marketing_vm
}

output "module_analytics_vm" {
  value = module.analytics_vm
}
OUTPUTS_EOF
echo "✅ Создан outputs.tf"

# Создаем cloud-init.yml
cat > cloud-init.yml << 'CLOUDINIT_EOF'
#cloud-config
users:
  - name: ubuntu
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - ${ssh_public_key}

package_update: true
packages:
  - nginx
  - curl

runcmd:
  - systemctl enable nginx
  - systemctl start nginx
CLOUDINIT_EOF
echo "✅ Создан cloud-init.yml"

# Создаем terraform.tfvars.example
cat > terraform.tfvars.example << 'TFVARS_EOF'
# terraform.tfvars.example
cloud_id  = "b1g..."  # Ваш Cloud ID
folder_id = "b1g..."  # Ваш Folder ID
default_zone = "ru-central1-a"
service_account_key_file = "~/.authorized_key.json"
subnet_id = "e9b..."  # ID вашей подсети
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDA8jQ4FkO... ваш_ключ ... user@host"
TFVARS_EOF
echo "✅ Создан terraform.tfvars.example"

# Создаем .gitignore
cat > .gitignore << 'GITIGNORE_EOF'
# Local .terraform directories
**/.terraform/*
*.tfstate
*.tfstate.*
crash.log
*.tfvars
*.tfvars.json
!terraform.tfvars.example
override.tf
.terraformrc
terraform.rc
*.json
GITIGNORE_EOF
echo "✅ Создан .gitignore"

# Создаем README.md
cat > README.md << 'README_EOF'
# Домашнее задание №4

## Задание 1

### Результаты

#### 1. Проверка nginx
*Скриншот 1: sudo nginx -t на marketing-vm*
*Скриншот 2: sudo nginx -t на analytics-vm*

#### 2. Метки в Yandex Cloud
*Скриншот 3: Метки marketing-vm*
*Скриншот 4: Метки analytics-vm*

#### 3. Terraform console
*Скриншот 5: module.marketing_vm*
*Скриншот 6: module.analytics_vm*

### Ссылка на код
[https://github.com/ваш-аккаунт/ваш-репозиторий/tree/terraform-04](https://github.com/ваш-аккаунт/ваш-репозиторий/tree/terraform-04)
README_EOF
echo "✅ Создан README.md"

# Создаем run.sh
cat > run.sh << 'RUN_EOF'
#!/bin/bash
echo "🚀 Запуск проекта..."
if [ ! -f terraform.tfvars ]; then
    echo "❌ Файл terraform.tfvars не найден!"
    echo "cp terraform.tfvars.example terraform.tfvars"
    exit 1
fi
terraform init
terraform plan
terraform apply -auto-approve
terraform output
RUN_EOF
chmod +x run.sh
echo "✅ Создан run.sh"

# Создаем cleanup.sh
cat > cleanup.sh << 'CLEANUP_EOF'
#!/bin/bash
echo "🧹 Очистка проекта..."
terraform destroy -auto-approve
rm -rf .terraform .terraform.lock.hcl
CLEANUP_EOF
chmod +x cleanup.sh
echo "✅ Создан cleanup.sh"

echo ""
echo "🎉 Все файлы успешно созданы!"
echo "📁 Директория проекта: $(pwd)"
echo ""
echo "📋 Следующие шаги:"
echo "1. Заполните terraform.tfvars: cp terraform.tfvars.example terraform.tfvars"
echo "2. Отредактируйте terraform.tfvars: nano terraform.tfvars"
echo "3. Запустите: ./run.sh"
