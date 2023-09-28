// Create a resource group.
resource "azurerm_resource_group" "arg" {
  location = var.region
  name     = var.name
}

// Create a network.
module "network" {
  source  = "Azure/network/azurerm"
  version = "3.5.0"

  address_space       = var.vpc_cidr
  resource_group_name = basename(azurerm_resource_group.arg.id)
  subnet_prefixes     = [var.vpc_cidr]
  tags                = local.tags
  vnet_name           = var.name
}

// Create the AKS cluster.
module "aks" {
  source = "../"

  name                = var.name
  owner               = var.owner
  region              = var.region
  resource_group_name = basename(azurerm_resource_group.arg.id)
  service_cidr        = var.service_cidr
  subnet_id           = module.network.vnet_subnets[0]
  network_plugin      = "none"
}

// Provision the AKS cluster.
module "provisioner" {
  source = "git::https://github.com/isovalent/terraform-k8s-cilium.git?ref=v1.0"

  cilium_helm_chart            = "cilium/cilium"
  cilium_helm_version          = "1.12.2"
  cilium_helm_values_file_path = "${abspath(path.module)}/cilium-helm-values.yaml"
  cilium_namespace             = "cilium"
  ipsec_key                    = var.ipsec_key
  path_to_kubeconfig_file      = module.aks.path_to_kubeconfig_file
}