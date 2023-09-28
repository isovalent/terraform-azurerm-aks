variable "ipsec_key" {
  description = "The IPsec key to use."
  sensitive   = true
  default     = ""
  type        = string
}

variable "kubernetes_version" {
  default     = "1.22.6"
  description = "The version of Kubernetes to use."
  type        = string
}

variable "name" {
  description = "The name of the AKS cluster."
  default     = "aks-example"
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

variable "owner" {
  description = "Your name."
  default     = "example run"
  type        = string
}

variable "paid_tier" {
  description = "Whether to use the \"Paid\" AKS tier."
  default     = false
  type        = bool
}

variable "region" {
  description = "The region in which to create the AKS cluster and associated resources."
  default     = "southcentralus"
  type        = string
}

variable "service_cidr" {
  default     = "10.0.0.0/16"
  description = "The CIDR to use for 'ClusterIP' services."
  type        = string
}

variable "subscription_id" {
  default = "22716d91-fb67-4a07-ac5f-d36ea49d6167" // cilium-dev
  type    = string
}

variable "tenant_id" {
  default = "625cda75-62dd-470e-a554-7313877ff03c" // cilium-dev
  type    = string
}


variable "vpc_cidr" {
  default     = "10.240.0.0/16"
  description = "The CIDR to use for the VPC."
  type        = string
}