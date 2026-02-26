output "network_id" {
  description = "ID of the created network"
  value       = yandex_vpc_network.this.id
}

output "network_name" {
  description = "Name of the created network"
  value       = yandex_vpc_network.this.name
}

output "subnets" {
  description = "List of created subnets with their details"
  value = [
    for subnet in yandex_vpc_subnet.this : {
      id         = subnet.id
      name       = subnet.name
      zone       = subnet.zone
      cidr_block = subnet.v4_cidr_blocks[0]
    }
  ]
}

# Для обратной совместимости с предыдущим кодом
output "subnet_ids" {
  description = "List of subnet IDs"
  value       = yandex_vpc_subnet.this[*].id
}

output "subnet_zones" {
  description = "List of subnet zones"
  value       = yandex_vpc_subnet.this[*].zone
}
