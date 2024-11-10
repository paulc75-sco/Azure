variable "name" {
  description = "Name of the resource group"
  type        = string
  validation {
    condition = (
      length(var.name) >= 1 &&
      length(var.name) <= 90 &&
      can(regex("^[a-zA-Z0-9-_()]+$", var.name))
    )
    error_message = "Resource group name must be between 1-90 characters and can only include alphanumeric, hyphens, underscores, and parentheses."
  }

}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "West Europe"
  validation {
    condition     = contains(["West Europe", "North Europe", "UK South", "UK West"], var.location)
    error_message = "Location must be a valid Azure region from the approved list."
  }

}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
  default = {
    "Investigate" = "Missing Value"
  }
  validation {
    condition     = can(lookup(var.tags, "Managed By", null)) && can(lookup(var.tags, "Business Owner", null))
    error_message = "Tags must include 'Managed By' and 'Business Owner' keys."
  }

}

variable "subscription_id" {
  type      = string
  sensitive = true
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", var.subscription_id))
    error_message = "Subscription ID must be a valid UUID format."
  }

}
