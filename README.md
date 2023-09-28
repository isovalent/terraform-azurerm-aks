# terraform-azure-aks

An opinionated Terraform module that can be used to create and manage an AKS cluster in Azure in a simplified way.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.3 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.28.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.22.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.28.1 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_availability_zones_data_source"></a> [availability\_zones\_data\_source](#module\_availability\_zones\_data\_source) | matti/resource/shell | 1.5.0 |
| <a name="module_cilium_service_principal"></a> [cilium\_service\_principal](#module\_cilium\_service\_principal) | git::https://github.com/isovalent/terraform-azuread-service-principal.git | v1.0 |
| <a name="module_main"></a> [main](#module\_main) | Azure/aks/azurerm | 6.4.0 |

## Resources

| Name | Type |
|------|------|
| [null_resource.kubeconfig](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_group.admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_azuread_group_names"></a> [admin\_azuread\_group\_names](#input\_admin\_azuread\_group\_names) | The list of Azure AD groups that should be granted admin access to the AKS cluster. | `list(string)` | `[]` | no |
| <a name="input_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#input\_docker\_bridge\_cidr) | The CIDR to use for the Docker bridge on the nodes. | `string` | `"172.16.0.0/16"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to use for the single node pool to be created. (NOTE: The upstream AKS module doesn't support multiple node pools yet.) | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The version of Kubernetes to use. | `string` | `"1.22.6"` | no |
| <a name="input_max_nodes"></a> [max\_nodes](#input\_max\_nodes) | The maximum number of nodes in the AKS cluster. | `number` | `4` | no |
| <a name="input_min_nodes"></a> [min\_nodes](#input\_min\_nodes) | The minimum number of nodes in the AKS cluster. | `number` | `3` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the AKS cluster. | `string` | n/a | yes |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | The network plugin to use (one of 'azure' or 'none'). | `string` | `"azure"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Your name. | `string` | n/a | yes |
| <a name="input_paid_tier"></a> [paid\_tier](#input\_paid\_tier) | Whether to use the "Paid" AKS tier. | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | The region in which to create the AKS cluster and associated resources. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Azure resource group in which to create the AKS cluster. | `string` | n/a | yes |
| <a name="input_root_disk_size"></a> [root\_disk\_size](#input\_root\_disk\_size) | The size (in GB) of the root disk. | `number` | `100` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | The CIDR block to use for services. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet where to place the node pool. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cilium_service_principal_client_id"></a> [cilium\_service\_principal\_client\_id](#output\_cilium\_service\_principal\_client\_id) | n/a |
| <a name="output_cilium_service_principal_client_secret"></a> [cilium\_service\_principal\_client\_secret](#output\_cilium\_service\_principal\_client\_secret) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | n/a |
| <a name="output_path_to_kubeconfig_file"></a> [path\_to\_kubeconfig\_file](#output\_path\_to\_kubeconfig\_file) | n/a |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | n/a |
<!-- END_TF_DOCS -->

## License

Copyright 2022 Isovalent, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
