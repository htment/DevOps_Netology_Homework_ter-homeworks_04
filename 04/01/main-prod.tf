# Тестовая конфигурация для задания 4
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"  # зона по умолчанию
}

# Вызов модуля для production с тремя подсетями
module "vpc_prod" {
  source   = "./modules/vpc-prod"
  env_name = "production"
  
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

# Вызов модуля для develop с одной подсетью
module "vpc_dev" {
  source   = "./modules/vpc-prod"
  env_name = "develop"
  
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.4.0/24" },
  ]
}

# Outputs для проверки
output "prod_vpc_info" {
  description = "Production VPC information"
  value = {
    network_id   = module.vpc_prod.network_id
    network_name = module.vpc_prod.network_name
    subnets      = module.vpc_prod.subnets
  }
}

output "dev_vpc_info" {
  description = "Development VPC information"
  value = {
    network_id   = module.vpc_dev.network_id
    network_name = module.vpc_dev.network_name
    subnets      = module.vpc_dev.subnets
  }
}

# Пример как использовать subnet_ids для ВМ
output "prod_subnet_ids" {
  description = "Production subnet IDs"
  value       = module.vpc_prod.subnet_ids
}

output "prod_first_subnet_id" {
  description = "First production subnet ID (for first VM)"
  value       = module.vpc_prod.subnet_ids[0]
}
