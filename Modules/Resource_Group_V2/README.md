# Azure Resource Group Terraform Module

This Terraform module creates an Azure Resource Group with configurable name, location, and tags. Resource Groups are logical containers for Azure resources that share the same lifecycle, permissions, and policies.

## Features

- 📍 Configurable Azure region
- 🏷️ Support for resource tagging
- 🔄 Output for resource group name and location
- 🌍 Default region set to West Europe

## Prerequisites

- Terraform >= 0.13.x
- Azure subscription
- Azure CLI installed and configured
- Appropriate Azure permissions to create resource groups

## Usage

### Basic Example
```hcl
module "resource_group" {
  source = "./path/to/module"

  global_name = "my-resources"
}
```

### Complete Example with Tags
```hcl
module "resource_group" {
  source = "./path/to/module"

  global_name     = "prod-resources"
  global_location = "North Europe"
  global_tags = {
    Environment = "Production"
    Department  = "IT"
    Owner       = "Platform Team"
    CostCenter  = "IT-123"
  }
}
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| global_name | Name of the resource group | string | n/a | yes |
| global_location | Azure region where the resource group will be created | string | "West Europe" | no |
| global_tags | Map of tags to apply to the resource group | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| rg | The name of the created resource group |
| location | The location/region of the created resource group |

## Example Usage with Other Resources

```hcl
# Create Resource Group
module "rg" {
  source = "./path/to/module"

  global_name = "app-resources"
  global_tags = {
    Environment = "Development"
  }
}

# Use Resource Group for other resources
resource "azurerm_storage_account" "example" {
  name                     = "examplestorage"
  resource_group_name      = module.rg.rg
  location                 = module.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

## Best Practices

1. **Naming Conventions**
   - Use consistent naming patterns
   - Follow your organization's naming standards
   - Consider including environment, purpose, and region in the name

2. **Tagging Strategy**
   - Implement consistent tagging for resource tracking
   - Include tags for:
     - Environment (prod, dev, test)
     - Owner/Team
     - Cost Center
     - Project
     - Application

3. **Resource Organization**
   - Group resources by lifecycle
   - Consider regulatory requirements
   - Align with business units or applications

## Recommendations

1. Use separate resource groups for:
   - Different environments (prod, dev, test)
   - Different applications
   - Resources with different lifecycle requirements

2. Apply proper access controls (RBAC) at the resource group level

3. Implement proper naming conventions following Azure best practices

## Known Limitations

1. Resource Group names must be unique within your subscription
2. Some Azure regions might not be available depending on your subscription
3. Tags are limited to 512 characters per tag value

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This module is licensed under the MIT License. See the LICENSE file for details.

## Support

For issues and feature requests, please submit an issue in the repository.

---
**Note**: Remember to test your resource group deployments in a non-production environment first.