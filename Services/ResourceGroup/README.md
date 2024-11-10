# Azure Resource Group Terraform Module

This Terraform module creates an Azure Resource Group with standardized tagging, naming conventions, and lifecycle management.

## Features

- Creates a single Azure Resource Group
- Enforces naming conventions and length restrictions
- Implements mandatory and common tagging standards
- Restricts deployment to approved Azure regions
- Prevents accidental deletion through lifecycle management
- Automatically captures creation metadata

## Prerequisites

- Terraform >= 0.13
- Azure subscription
- Azure CLI or appropriate service principal credentials
- Contributor access to the target Azure subscription

## Required Providers

```hcl
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
```

## Usage

```hcl
module "resource_group" {
  source = "./path/to/module"

  name            = "rg-project-dev-001"
  location        = "West Europe"
  subscription_id = "00000000-0000-0000-0000-000000000000"
  
  tags = {
    "Managed By"      = "Platform Team"
    "Business Owner"  = "Department X"
    "Project"         = "Project Y"
  }
}
```

## Required Input Variables

| Name | Description | Type | Example |
|------|-------------|------|---------|
| name | Name of the resource group (1-90 characters) | `string` | `"rg-project-dev-001"` |
| subscription_id | Azure subscription ID | `string` | `"00000000-0000-0000-0000-000000000000"` |
| tags | Resource tags including required 'Managed By' and 'Business Owner' | `map(string)` | See example above |

## Optional Input Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| location | Azure region for deployment | `string` | `"West Europe"` |

## Validation Rules

### Resource Group Name
- Length: 1-90 characters
- Allowed characters: alphanumeric, hyphens, underscores, and parentheses
- Pattern: `^[a-zA-Z0-9-_()]+$`

### Location
Allowed values:
- West Europe
- North Europe
- UK South
- UK West

### Tags
Required tags:
- Managed By
- Business Owner

## Outputs

| Name | Description |
|------|-------------|
| resource_group_id | The full resource ID of the created resource group |
| resource_group_name | The name of the created resource group |

## Automatic Tagging

The module automatically adds the following tags:
- Environment: Based on Terraform workspace
- LastUpdated: Timestamp of last deployment
- Created By: User Principal Name of the deploying user

## Lifecycle Management

The resource group is protected with the following lifecycle rules:
- `prevent_destroy = true`: Prevents accidental deletion
- Ignores changes to the "Created By" tag