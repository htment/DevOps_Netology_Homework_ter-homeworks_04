# main.tf
# Получаем информацию о созданной подсети
# data "yandex_vpc_subnet" "selected" {
#   subnet_id = yandex_vpc_subnet.develop_a.id
# }

module "vpc_dev" {
  source   = "../02/terraform/modules/vpc"
  env_name = var.env_name
  zone     = var.vpc_zone
  cidr     = var.vpc_cidr
}



module "marketing_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  env_name       = "marketing"
  #network_id     = data.yandex_vpc_subnet.selected.network_id  #Задание1
  network_id     = module.vpc_dev.network_id                    # Берем из модуля VPC
 # subnet_zones   = [var.default_zone]                           
  subnet_zones   = [var.vpc_zone]                               # Берем из модуля VPC
  #subnet_ids     = [yandex_vpc_subnet.develop_a.id]            #Задание1
  subnet_ids     = [module.vpc_dev.subnet_id]                   # Берем из модуля VPC
  
  
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
      ssh_public_key = file("~/.ssh/id_ed25519.pub")
    })
  }
}

module "analytics_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  env_name       = "analytics"
  #network_id     = data.yandex_vpc_subnet.selected.network_id
  network_id     = module.vpc_dev.network_id                    # Берем из модуля VPC
  subnet_zones   = [var.vpc_zone]                               # Берем из модуля VPC
  #subnet_zones   = [var.default_zone]
  #subnet_ids     = [yandex_vpc_subnet.develop_a.id] 
  subnet_ids     = [module.vpc_dev.subnet_id]                   # Берем из модуля VPC
  
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
     ssh_public_key = file("~/.ssh/id_ed25519.pub")
    })
  }
}
