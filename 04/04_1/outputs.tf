# Outputs for VPC modules
# Outputs for VPC modules
output "vpc_dev_network_id" {
  description = "ID of the develop VPC network"
  value       = module.vpc_dev.network_id
}

output "vpc_dev_subnet_ids" {
  description = "IDs of develop subnets"
  value       = module.vpc_dev.subnet_ids
}

output "vpc_prod_network_id" {
  description = "ID of the production VPC network"
  value       = module.vpc_prod.network_id
}

output "vpc_prod_subnet_ids" {
  description = "IDs of production subnets"
  value       = module.vpc_prod.subnet_ids
}

# External IPs for SSH connection - используем правильные атрибуты
output "marketing_vm_ssh_ip" {
  description = "External IP for SSH connection to marketing VM"
  value       = module.marketing_vm.external_ip_address[0]
}

output "analytics_vm_ssh_ip" {
  description = "External IP for SSH connection to analytics VM"
  value       = module.analytics_vm.external_ip_address[0]
}

# Internal IPs
output "marketing_vm_internal_ip" {
  description = "Internal IP of marketing VM"
  value       = module.marketing_vm.internal_ip_address[0]
}

output "analytics_vm_internal_ip" {
  description = "Internal IP of analytics VM"
  value       = module.analytics_vm.internal_ip_address[0]
}

# Команды для подключения
output "ssh_commands" {
  description = "SSH commands to connect to VMs"
  value = {
    marketing = "ssh ubuntu@${module.marketing_vm.external_ip_address[0]}"
    analytics = "ssh ubuntu@${module.analytics_vm.external_ip_address[0]}"
  }
}

output "demo_content" {
  value = local_file.demo.content
}