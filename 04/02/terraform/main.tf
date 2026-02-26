# Модуль VPC
module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = var.env_name
  zone     = var.vpc_zone
  cidr     = var.vpc_cidr
}

# # Модуль виртуальной машины (пример, замените на ваш существующий модуль)
# module "vm" {
#   source         = "./vm"  # или путь к вашему модулю VM
#   vm_name        = var.vm_name
#   subnet_id      = module.vpc_dev.subnet_id
#   # другие параметры...
# }