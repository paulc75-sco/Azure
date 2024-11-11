variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{3,24}$", var.kv_name))
    error_message = "Key vault name must be between 3-24 characters long and can only contain alphanumeric characters and hyphens."
  }
}

variable "location" {
  description = "Azure region for Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string

}

variable "kv_sku_name" {
  description = "SKU name for the Key Vault (standard or premium)"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.kv_sku_name)
    error_message = "SKU name must be either 'standard' or 'premium'."
  }
}

variable "tenant_id" {
  description = "value"
  type        = string

}

variable "kv_enabled_for_disk_encryption" {
  description = "Enable disk encryption"
  type        = bool
  default     = true

}

variable "kv_purge_protection_enabled" {
  description = "Enable purge protection"
  type        = bool
  default     = true

}

variable "kv_soft_delete_retention_days" {
  description = "Amount of days to retain items in soft delete"
  type        = number
  default     = 7
  validation {
    condition     = var.kv_soft_delete_retention_days >= 7 && var.kv_soft_delete_retention_days <= 90
    error_message = "Soft delete retention days must be between 7 and 90 days."
  }
}

variable "access_policies" {
  type = list(object({
    object_id               = string
    application_id          = optional(string)
    certificate_permissions = optional(list(string), [])
    key_permissions         = optional(list(string), [])
    secret_permissions      = optional(list(string), [])
    storage_permissions     = optional(list(string), [])
  }))
  description = "List of access policy configurations"
  default     = []
}

variable "secrets" {
  type = map(object({
    value           = string
    content_type    = optional(string)
    tags            = optional(map(string))
    expiration_date = optional(string)
    not_before_date = optional(string)
  }))
  description = "Map of secrets to create"
  default     = {}
}

variable "network_rules" {
  type = object({
    default_action             = optional(string, "Deny")
    bypass                     = optional(string, "AzureServices")
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  description = "Network rules for the Key Vault"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Key Vault"
  default     = {}
}

variable "kv_public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this Key Vault."
  type        = bool
  default     = false

}

variable "private_endpoint" {
  description = "Private endpoint configuration"
  type = object({
    name                        = string
    subnet_id                   = string
    private_dns_zone_ids        = optional(list(string), [])
    private_dns_zone_group_name = optional(string, "default")
    is_manual_connection        = optional(bool, false)
    tags                        = optional(map(string), {})
  })
  default = null
}
