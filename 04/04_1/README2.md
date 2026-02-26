## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.12.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.2 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | ~> 0.130 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_analytics_vm"></a> [analytics\_vm](#module\_analytics\_vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_marketing_vm"></a> [marketing\_vm](#module\_marketing\_vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_vpc_dev"></a> [vpc\_dev](#module\_vpc\_dev) | ./modules/vpc | n/a |
| <a name="module_vpc_prod"></a> [vpc\_prod](#module\_vpc\_prod) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.demo](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_boot_disk_size"></a> [boot\_disk\_size](#input\_boot\_disk\_size) | Boot disk size for VMs in GB | `number` | `10` | no |
| <a name="input_boot_disk_type"></a> [boot\_disk\_type](#input\_boot\_disk\_type) | Boot disk type for VMs | `string` | `"network-hdd"` | no |
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | Yandex Cloud ID | `string` | n/a | yes |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone) | Default availability zone | `string` | `"ru-central1-a"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Yandex Cloud Folder ID | `string` | n/a | yes |
| <a name="input_image_family"></a> [image\_family](#input\_image\_family) | Image family for VMs | `string` | `"ubuntu-2204-lts"` | no |
| <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path) | Path to SSH public key file | `string` | `"~/.ssh/id_ed25519.pub"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for VPC | `string` | `"10.0.1.0/24"` | no |
| <a name="input_vpc_zone"></a> [vpc\_zone](#input\_vpc\_zone) | Availability zone for VPC | `string` | `"ru-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_analytics_vm_internal_ip"></a> [analytics\_vm\_internal\_ip](#output\_analytics\_vm\_internal\_ip) | Internal IP of analytics VM |
| <a name="output_analytics_vm_ssh_ip"></a> [analytics\_vm\_ssh\_ip](#output\_analytics\_vm\_ssh\_ip) | External IP for SSH connection to analytics VM |
| <a name="output_demo_content"></a> [demo\_content](#output\_demo\_content) | n/a |
| <a name="output_marketing_vm_internal_ip"></a> [marketing\_vm\_internal\_ip](#output\_marketing\_vm\_internal\_ip) | Internal IP of marketing VM |
| <a name="output_marketing_vm_ssh_ip"></a> [marketing\_vm\_ssh\_ip](#output\_marketing\_vm\_ssh\_ip) | External IP for SSH connection to marketing VM |
| <a name="output_ssh_commands"></a> [ssh\_commands](#output\_ssh\_commands) | SSH commands to connect to VMs |
| <a name="output_vpc_dev_network_id"></a> [vpc\_dev\_network\_id](#output\_vpc\_dev\_network\_id) | ID of the develop VPC network |
| <a name="output_vpc_dev_subnet_ids"></a> [vpc\_dev\_subnet\_ids](#output\_vpc\_dev\_subnet\_ids) | IDs of develop subnets |
| <a name="output_vpc_prod_network_id"></a> [vpc\_prod\_network\_id](#output\_vpc\_prod\_network\_id) | ID of the production VPC network |
| <a name="output_vpc_prod_subnet_ids"></a> [vpc\_prod\_subnet\_ids](#output\_vpc\_prod\_subnet\_ids) | IDs of production subnets |
