// Copyright 2022 Isovalent, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Grab the list of availablity zones for the chosen region.
// https://github.com/hashicorp/terraform-provider-azurerm/issues/3025#issuecomment-644014237
module "availability_zones_data_source" {
  source  = "matti/resource/shell"
  version = "1.5.0"

  command = "az vm list-skus --location ${var.region} --zone --resource-type virtualMachines --size ${var.instance_type} --query '[].locationInfo[0].zones' --output jsonc"
}


// Grab the Azure AD groups so as to make them admins of the AKS cluster.
data "azuread_group" "admins" {
  for_each = toset(var.admin_azuread_group_names)

  display_name = each.value
}

// Create an AKS cluster.
module "main" {
  source  = "Azure/aks/azurerm"
  version = "6.0.0"

  agents_availability_zones         = sort(flatten(jsondecode(module.availability_zones_data_source.stdout)))
  agents_max_count                  = var.max_nodes
  agents_min_count                  = var.min_nodes
  agents_pool_name                  = local.pool_name
  agents_tags                       = local.tags
  cluster_name                      = var.name
  enable_auto_scaling               = true
  role_based_access_control_enabled = true
  kubernetes_version                = var.kubernetes_version
  net_profile_docker_bridge_cidr    = var.docker_bridge_cidr
  net_profile_dns_service_ip        = cidrhost(var.service_cidr, 10)
  net_profile_service_cidr          = var.service_cidr
  network_plugin                    = var.network_plugin
  orchestrator_version              = var.kubernetes_version
  os_disk_size_gb                   = var.root_disk_size
  private_cluster_enabled           = false
  rbac_aad_admin_group_object_ids = [
    for k, v in data.azuread_group.admins : v.id
  ]
  rbac_aad_managed    = true
  resource_group_name = var.resource_group_name
  sku_tier            = var.paid_tier ? "Paid" : "Free"
  prefix              = var.name
  vnet_subnet_id      = var.subnet_id
}

// Create an Azure AD service principal that Cilium can run under.
module "cilium_service_principal" {
  source = "git::https://github.com/isovalent/terraform-azuread-service-principal.git?ref=v1.0"

  application_name = "${var.name}-cilium"
}

// Make sure the kubeconfig file always exists.
// This is necessary because running 'terraform init' may replace the directory containing it when run.
resource "null_resource" "kubeconfig" {
  depends_on = [
    module.main, // Do not run before the AKS cluster is up.
  ]
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "az aks get-credentials --admin --overwrite-existing --name ${var.name} --resource-group ${var.name}"
    environment = {
      KUBECONFIG = local.path_to_kubeconfig_file,
    }
  }
}
