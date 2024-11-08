####################
# Global Vairables #
####################

variable "global_location" {
  description = "Location for deployment"
  type        = string
  default     = "West Europe"

}

variable "global_rg" {
  description = "Name of the resource group"
  type        = string

}

variable "global_dns_servers" {
  description = "Custom DNS servers for the vnet"
  type        = list(string)
  default     = []


}

variable "global_tags" {

}

##################
# Vnet Vairables #
##################

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string

}

variable "vnet_address_space" {
  description = "Global address space for the vnet"
  type        = list(string)
  default     = ["10.0.0.0/16"]

}

variable "vnet_subnets" {
  type = map(object({
    name             = string
    address_prefixes = string
  }))
  default = {}
}


