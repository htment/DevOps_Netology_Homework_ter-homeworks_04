output "network_id" {
  description = "ID of the created VPC network"
  value       = yandex_vpc_network.this.id
}

output "subnet_ids" {
  description = "List of IDs of created subnets"
  value       = yandex_vpc_subnet.this[*].id
}

# Для обратной совместимости, если нужен ID первой подсети
output "subnet_id" {
  description = "ID of the first subnet (for backward compatibility)"
  value       = try(yandex_vpc_subnet.this[0].id, null)
}