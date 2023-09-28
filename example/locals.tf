locals {
  path_to_kubeconfig_file = "./${var.name}.kubeconfig" // The path to the kubeconfig file that will be created and output.
  tags = {
    "owner" : var.owner,
  }
}