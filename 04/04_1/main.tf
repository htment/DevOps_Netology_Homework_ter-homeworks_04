# main.tf


module "vpc_prod" {
  source   = "./modules/vpc"
  env_name = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },  
  ]
}

# Для разработки (одна подсеть)
module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}


module "marketing_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  env_name     = "marketing"
  network_id   = module.vpc_dev.network_id
  subnet_zones = [var.vpc_zone]
  subnet_ids   = [module.vpc_dev.subnet_ids[0]] # используем первую подсеть

  instance_name          = "marketing-vm"
  instance_count         = 1
  instance_cores         = 2
  instance_memory        = 2
  instance_core_fraction = 20
  boot_disk_type         = var.boot_disk_type
  boot_disk_size         = var.boot_disk_size
  public_ip              = true
  image_family           = var.image_family
  preemptible            = true

  labels = {
    project     = "marketing"
    environment = "production"
    created_by  = "terraform"
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml", {
      ssh_public_key = file("~/.ssh/id_ed25519.pub")
      project_name   = "marketing"
    })
  }
}

module "analytics_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  env_name     = "analytics"
  network_id   = module.vpc_dev.network_id
  subnet_zones = [var.vpc_zone]
  subnet_ids   = [module.vpc_dev.subnet_ids[0]]

  instance_name          = "analytics-vm"
  instance_count         = 1
  instance_cores         = 2
  instance_memory        = 4
  instance_core_fraction = 20
  boot_disk_type         = var.boot_disk_type
  boot_disk_size         = var.boot_disk_size
  public_ip              = true
  image_family           = var.image_family
  preemptible            = true

  labels = {
    project         = "analytics"
    environment     = "production"
    created_by      = "terraform"
    data_processing = "true"
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml", {
      ssh_public_key = file("~/.ssh/id_ed25519.pub")
      project_name   = "analytics"
    })
  }
}


resource "local_file" "demo" {
  content  = "Demo file for Terraform state operations"
  filename = "${path.module}/demo.txt"
}