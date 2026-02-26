output "subnet" {
  description = "Subnet resource object"
  value       = yandex_vpc_subnet.this
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = yandex_vpc_subnet.this.id
}

output "network_id" {
  description = "ID of the created network"
  value       = yandex_vpc_network.this.id
}

output "network_name" {
  description = "Name of the created network"
  value       = yandex_vpc_network.this.name
}

output "subnet_name" {
  description = "Name of the created subnet"
  value       = yandex_vpc_subnet.this.name
}

output "zone" {
  description = "Zone of the subnet"
  value       = yandex_vpc_subnet.this.zone
}

output "cidr_blocks" {
  description = "CIDR blocks of the subnet"
  value       = yandex_vpc_subnet.this.v4_cidr_blocks
}
