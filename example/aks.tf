// Create a resource group.
resource "azurerm_resource_group" "arg" {
  location = var.region
  name     = var.name
}

// Create a network.
module "network" {
  source  = "Azure/network/azurerm"
  version = "5.3.0"

  use_for_each = false
  depends_on   = [azurerm_resource_group.arg]

  address_space       = var.vpc_cidr
  resource_group_name = basename(azurerm_resource_group.arg.id)
  subnet_prefixes     = [var.vpc_cidr]
  tags                = local.tags
  vnet_name           = var.name
}

// Create the AKS cluster.
module "aks" {
  source = "../"

  depends_on = [azurerm_resource_group.arg]

  name                = var.name
  owner               = var.owner
  region              = var.region
  resource_group_name = basename(azurerm_resource_group.arg.id)
  service_cidr        = var.service_cidr
  subnet_id           = module.network.vnet_subnets[0]
  network_plugin      = "none"
}

// Provision the AKS cluster.
module "cilium" {
  source = "git::https://github.com/isovalent/terraform-k8s-cilium.git?ref=v1.6.3"

  cilium_helm_release_name              = "cilium"
  cilium_helm_chart                     = "cilium/cilium"
  cilium_helm_version                   = "1.15.5"
  cilium_helm_values_file_path          = "${abspath(path.module)}/cilium-helm-values.yaml"
  cilium_namespace                      = "cilium"
  path_to_kubeconfig_file               = module.aks.path_to_kubeconfig_file
  cilium_helm_values_override_file_path = var.cilium_helm_values_override_file
}