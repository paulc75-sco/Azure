# Azure Resource Group Terraform Module

This Terraform module creates an Azure Resource Group with standardized naming, tagging, and lifecycle management.

## Features

- Automated resource group creation with standardized configuration
- Validation for resource group naming conventions
- Required and automated tagging including creation details
- Lifecycle management to prevent accidental deletion
- Automated capture of deployment user and timestamp
- Region restriction to approved Azure locations

## Prerequisites

- Terraform >= 1.0
- Azure CLI or Azure PowerShell configured
- Azure AD permissions to read user information
- Azure subscription with contributor access

## Required Providers

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }
}
```

## Module Structure

```plaintext
.
├── main.tf              # Main resource configuration
├── variables.tf         # Variable declarations
├── terraform.tfvars     # Variable definitions
├── providers.tf         # Provider configurations
└── README.md           # This file
```

## Usage

1. Basic usage:

```hcl
module "resource_group" {
  source = "./path/to/module"

  name     = "rg-project-prod-001"
  location = "West Europe"
  tags     = {
    "Name"           = "Project Name"
    "Department"     = "Department Name"
    "Business Owner" = "Owner Name"
    "Managed By"     = "Terraform"
  }
  subscription_id = "your-subscription-id"
}
```

2. Example tfvars file:

```hcl
name = "rg-project-prod-001"
tags = {
  "Name"           = "Project Name"
  "Department"     = "Department Name"
  "Business Owner" = "Owner Name"
  "Managed By"     = "Terraform"
}
subscription_id = "your-subscription-id"
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name of the resource group | string | - | yes |
| location | Azure region where resources will be created | string | "West Europe" | no |
| tags | Map of tags to apply to the resource group | map(string) | - | yes |
| subscription_id | Azure subscription ID | string | - | yes |

### Variable Validation Rules

#### Resource Group Name
- Length: 1-90 characters
- Allowed characters: alphanumeric, hyphens, underscores, and parentheses
- Pattern: `^[a-zA-Z0-9-_()]+$`

#### Location
Allowed values:
- West Europe
- North Europe
- UK South
- UK West

#### Tags
Required tags:
- "Managed By"
- "Business Owner"

Additional tags automatically added:
- "Created By" (deploying user's UPN)
- "Created Date" (timestamp of deployment)

## Outputs

| Name | Description |
|------|-------------|
| resource_group_id | The ID of the created resource group |
| resource_group_name | The name of the created resource group |

## Lifecycle Management

The module implements the following lifecycle policies:
- Prevents accidental deletion of the resource group
- Ignores changes to creation-time tags to prevent unnecessary updates

## Best Practices Implemented

1. **Naming Convention**
   - Enforced through validation rules
   - Consistent with Azure naming restrictions

2. **Tagging Strategy**
   - Mandatory business and technical tags
   - Automated tracking of creation details
   - Prevents tag-only updates for creation-time information

3. **Security**
   - Sensitive variables marked appropriately
   - Prevention of accidental resource deletion
   - Region restrictions to approved locations

4. **Maintainability**
   - Clear variable definitions
   - Input validation
   - Structured code organization

## Contributing

When contributing to this module:
1. Update validation rules if new regions are approved
2. Maintain existing tag structure
3. Test changes thoroughly before deployment
4. Update documentation as needed

## Notes

- The prevent_destroy lifecycle rule is set to true by default
- Tag changes for "Created By" and "Created Date" are ignored to prevent unnecessary updates
- Subscription ID is marked as sensitive in logs

## Support

For issues and feature requests, please contact the infrastructure team.