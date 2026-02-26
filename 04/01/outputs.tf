

# outputs.tf (новый, для исследования)
output "marketing_vm_details" {
  value = module.marketing_vm
}

output "analytics_vm_details" {
  value = module.analytics_vm
}


output "marketing_vm_info" {
  value = {
    name         = module.marketing_vm.all[0].name
    external_ip  = module.marketing_vm.external_ip_address[0]
    internal_ip  = module.marketing_vm.internal_ip_address[0]
    fqdn         = module.marketing_vm.fqdn[0]
    id           = module.marketing_vm.all[0].id
    labels       = module.marketing_vm.labels[0]
    platform_id  = module.marketing_vm.all[0].platform_id
    zone         = module.marketing_vm.all[0].zone
    created_at   = module.marketing_vm.all[0].created_at
  }
  description = "Информация о VM маркетинга"
}


output "analytics_vm_info" {
  value = {
    name         = module.analytics_vm.all[0].name
    external_ip  = module.analytics_vm.external_ip_address[0]
    internal_ip  = module.analytics_vm.internal_ip_address[0]
    fqdn         = module.analytics_vm.fqdn[0]
    id           = module.analytics_vm.all[0].id
    labels       = module.analytics_vm.labels[0]
    platform_id  = module.analytics_vm.all[0].platform_id
    zone         = module.analytics_vm.all[0].zone
    created_at   = module.analytics_vm.all[0].created_at
  }
  description = "Информация о VM аналитики"
}

# Информация о сети
# output "network_info" {
#   value = {
#     network_id   = yandex_vpc_network.develop.id
#     network_name = yandex_vpc_network.develop.name
#     subnet_id    = yandex_vpc_subnet.develop_a.id
#     subnet_name  = yandex_vpc_subnet.develop_a.name
#     subnet_cidr  = yandex_vpc_subnet.develop_a.v4_cidr_blocks[0]
#     subnet_zone  = yandex_vpc_subnet.develop_a.zone
#   }
#   description = "Информация о созданной сети"
# }

output "vpc_info" {
  description = "Information about created VPC"
  value = {
    network_id   = module.vpc_dev.network_id
    network_name = module.vpc_dev.network_name
    subnet_id    = module.vpc_dev.subnet_id
    subnet_name  = module.vpc_dev.subnet_name
    zone         = module.vpc_dev.zone
    cidr         = module.vpc_dev.cidr_blocks
  }
}

# output "connect_instructions" {
#   value = <<-EOT
#     📋 ИНСТРУКЦИИ ПО ПОДКЛЮЧЕНИЮ:
    
#     🔵 VM МАРКЕТИНГА:
#     Название: ${module.marketing_vm.name}
#     Внешний IP: ${module.marketing_vm.external_ip}
#     Внутренний IP: ${module.marketing_vm.internal_ip}
    
#     Команда для подключения:
#     ssh ubuntu@${module.marketing_vm.external_ip}
    
#     🟢 VM АНАЛИТИКИ:
#     Название: ${module.analytics_vm.name}
#     Внешний IP: ${module.analytics_vm.external_ip}
#     Внутренний IP: ${module.analytics_vm.internal_ip}
    
#     Команда для подключения:
#     ssh ubuntu@${module.analytics_vm.external_ip}
    
#     🔧 ПРОВЕРКА NGINX НА ВМ:
#     sudo nginx -t
#     curl localhost
#     systemctl status nginx
    
#     🌐 ИНФОРМАЦИЯ О СЕТИ:
#     Network ID: ${yandex_vpc_network.develop.id}
#     Network Name: ${yandex_vpc_network.develop.name}
#     Subnet ID: ${yandex_vpc_subnet.develop_a.id}
#     Subnet Name: ${yandex_vpc_subnet.develop_a.name}
#     Subnet CIDR: ${yandex_vpc_subnet.develop_a.v4_cidr_blocks[0]}
#     Subnet Zone: ${yandex_vpc_subnet.develop_a.zone}
#   EOT
# }


# Для быстрого получения IP адресов (удобно для скриптов)
output "marketing_vm_ip" {
  value = module.marketing_vm.external_ip_address[0]
  description = "Внешний IP адрес marketing VM"
}

output "analytics_vm_ip" {
  value = module.analytics_vm.external_ip_address[0]
  description = "Внешний IP адрес analytics VM"
}

# # Для отладки (можно закомментировать после проверки)
# output "marketing_vm_full" {
#   value = module.marketing_vm
#   description = "Полная структура marketing VM (для отладки)"
# }

# output "analytics_vm_full" {
#   value = module.analytics_vm
#   description = "Полная структура analytics VM (для отладки)"
# }



# debug.tf
# Временно закомментируем все outputs в outputs.tf и используем этот файл

# output "module_marketing_debug" {
#   value = module.marketing_vm
# }

# output "module_analytics_debug" {
#   value = module.analytics_vm
# }

# # Также посмотрим на ресурсы
# output "yandex_vpc_network_debug" {
#   value = yandex_vpc_network.develop
# }

# output "yandex_vpc_subnet_debug" {
#   value = yandex_vpc_subnet.develop_a
# }

