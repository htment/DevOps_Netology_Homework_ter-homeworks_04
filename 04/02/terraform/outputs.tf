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

# Существующие output...