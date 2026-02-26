resource "yandex_compute_instance" "vm" {
  count = var.instance_count

  name        = "${var.env_name}-${var.instance_name}-${count.index}"
  platform_id = "standard-v3"
  
  resources {
    cores         = var.instance_cores
    memory        = var.instance_memory
    core_fraction = var.instance_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.boot_disk_type
      size     = var.boot_disk_size
    }
  }

  network_interface {
    network_id = var.network_id
    subnet_id  = var.subnet_ids[count.index % length(var.subnet_ids)]
    nat        = var.public_ip
  }

  metadata = {
    user-data = templatefile(var.cloud_init_path, {
      ssh_public_key = var.ssh_public_key
      project_name  = var.env_name
    })
  }

  labels = merge(var.labels, {
    env         = var.env_name
    created_by  = "terraform"
  })
}

data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}
