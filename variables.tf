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

variable "admin_azuread_group_names" {
  default     = []
  description = "The list of Azure AD groups that should be granted admin access to the AKS cluster."
  type        = list(string)
}

variable "instance_type" {
  default     = "Standard_D2s_v3"
  description = "The type of instance to use for the single node pool to be created. (NOTE: The upstream AKS module doesn't support multiple node pools yet.)"
  type        = string
}

variable "kubernetes_version" {
  default     = "1.29.4"
  description = "The version of Kubernetes to use."
  type        = string
}

variable "name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "max_nodes" {
  default     = 4
  description = "The maximum number of nodes in the AKS cluster."
  type        = number
}

variable "min_nodes" {
  default     = 3
  description = "The minimum number of nodes in the AKS cluster."
  type        = number
}

variable "network_plugin" {
  description = "The network plugin to use (one of 'azure' or 'none')."
  default     = "azure"
  type        = string
}

variable "owner" {
  description = "Your name."
  type        = string
}

variable "paid_tier" {
  description = "Whether to use the \"Standard\" AKS tier."
  default     = false
  type        = bool
}

variable "region" {
  description = "The region in which to create the AKS cluster and associated resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure resource group in which to create the AKS cluster."
  type        = string
}

variable "root_disk_size" {
  default     = 100
  description = "The size (in GB) of the root disk."
  type        = number
}

variable "service_cidr" {
  description = "The CIDR block to use for services."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where to place the node pool."
  type        = string
}

variable "kube_proxy_disabled" {
  description = "Disable kube-proxy"
  default     = false
  type        = bool
}

variable "sp_enabled" {
  description = "Set to false to disable service principle creation"
  default     = true
  type        = bool
}

variable "oidc_issuer_enabled" {
  description = "Enable OIDC issuer"
  default     = false
  type        = bool
}

variable "workload_identity_enabled" {
  description = "Enable workload identity"
  default     = false
  type        = bool
}

variable "enable_auto_scaling" {
  description = "Enable auto scaling"
  default     = false
  type        = bool
}