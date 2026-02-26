# Создаем сеть
resource "yandex_vpc_network" "this" {
  name = "${var.env_name}-network"
}

# Создаем подсети для каждой зоны из списка
resource "yandex_vpc_subnet" "this" {
  count = length(var.subnets)
  
  name           = "${var.env_name}-subnet-${var.subnets[count.index].zone}"
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
}
