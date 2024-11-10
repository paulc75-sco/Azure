variable "name" {
  description = "Name of the storage account and validation"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "Storage account name must be 3-24 characters long and can only contain lowercase letters and numbers."
  }

}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "West Europe"
}

variable "account_tier" {
  description = "Tier of the storage account (Standard or Premium)"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be either Standard or Premium."
  }

}

variable "account_replication_type" {
  description = "Type of replication for the storage account"
  type        = string
  default     = "LRS"
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS"], var.account_replication_type)
    error_message = "Replication type must be one of: LRS, GRS, RAGRS, ZRS."
  }

}

variable "container_name" {
  description = "Name of the storage container"
  type        = string

}

variable "container_access_type" {
  default = "private"

}

variable "tags" {
  type = map(string)
}

variable "subscription_id" {
  type = string

}

variable "allowed_ip_ranges" {
  description = "List of IP ranges that can access the storage account"
  type        = list(string)
  default     = []


}

variable "subnet_ids" {
  description = "List of subnet IDs that can access the storage account"
  type        = list(string)
  default     = []

}
