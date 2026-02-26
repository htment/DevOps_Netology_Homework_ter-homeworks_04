# modules/vpc-prod/outputs.tf
output "network_id" {
  value = yandex_vpc_network.this.id
}

output "subnet_ids" {
  value = yandex_vpc_subnet.this[*].id
}

output "subnet_id" {
  value = yandex_vpc_subnet.this[0].id
}