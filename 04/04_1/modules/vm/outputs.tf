output "external_ip_address" {
  description = "External IP addresses"
  value       = yandex_compute_instance.vm[*].network_interface[0].nat_ip_address
}

output "internal_ip_address" {
  description = "Internal IP addresses"
  value       = yandex_compute_instance.vm[*].network_interface[0].ip_address
}

output "fqdn" {
  description = "FQDN of instances"
  value       = yandex_compute_instance.vm[*].fqdn
}

output "instance_names" {
  description = "Instance names"
  value       = yandex_compute_instance.vm[*].name
}
