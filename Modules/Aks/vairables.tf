variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "rg_name" {
  description = "Resource Group Name"
  type        = string

}

variable "aks_dns_prefix" {
  description = "DNS prefix to be used with the AKS cluster"
  type        = string

}

variable "aks_dnp_name" {
  description = "Name for the default node pool"
  type        = string

}

variable "aks_dnp_node_count" {
  description = "Number of servers to be deployed into the pool"
  type        = number
  default     = 1

}

variable "aks_dnp_vm_size" {
  description = "VM SKU to be used with the cluster"
  type        = string

}

variable "tags" {
  description = "Tags to be added to the cluster"
  type        = map(string)

}

variable "aks_identity_type" {
  description = "Identiy type to be assigned to the cluster"
  type        = string

}

variable "aks_version" {
  description = "AKS version to use on the cluster"
  type        = string

}

variable "aks_max_count" {
  description = "Maximum node count"
  type        = number
  default     = 5

}

variable "aks_min_count" {
  description = "Minimum node count"
  type        = number
  default     = 1

}
variable "aks_vnet_subnet_id" {
  description = "Subnet id for the node pool"
  type        = string

}

variable "aks_np_network_plugin" {
  description = "Sets the network plugin for the cluster"
  type        = string
  default     = "azure"

}

variable "aks_np_network_policy" {
  description = "Sets the netwprk policy for the cluster"
  type        = string
  default     = "calico"

}

variable "aks_np_load_balancer_sku" {
  description = "Sets the loadbalancer sku to be used"
  type        = string
  default     = "standard"

}

variable "aks_np_service_cidr" {
  description = "CIDR range for service IPs"
  type        = string

}

variable "aks_np_dns_service_ip" {
  description = "IP address within the service CIDR for the DNS service"
  type        = string

}

variable "aks_dnp_auto_scaling_enabled" {
  description = "COntrol auto scaling in the cluster"
  type        = bool
  default     = true

}

variable "aks_dnp_zones" {
  description = "A list of Availability Zones across which the Node Pool should be spread"
  type        = list(string)
  default     = ["1", "2", "3"]

}

variable "aks_dnp_os_disk_size_gb" {
  description = "The size of the OS Disk which should be used for each agent pool node"
  type        = number
  default     = 128

}

variable "aks_dnp_os_disk_type" {
  description = "The type of disk which should be used for the Operating System"
  type        = string
  default     = "Managed"

}

variable "aks_mw_day" {
  description = "The day of the week for maintenance window"
  type        = string
  default     = "Sunday"

}

variable "aks_mw_hour" {
  description = "A list of hour slots when maintenance is allowed"
  type        = list(number)
  default     = [0, 1, 2, 3, 4]

}


