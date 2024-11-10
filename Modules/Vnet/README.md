# Azure Virtual Network Terraform Module

This Terraform module creates an Azure Virtual Network with configurable subnets, DNS servers, and address spaces. It provides a flexible way to deploy networking infrastructure in Azure with support for multiple subnets and custom DNS configurations.

## Features

- 🌐 Configurable address space
- 🔀 Dynamic subnet creation
- 🔍 Custom DNS server support
- 🏷️ Resource tagging
- 📍 Regional deployment
- 🔄 Flexible subnet configuration using maps

## Prerequisites

- Terraform >= 0.13.x
- Azure subscription
- Azure CLI installed and configured
- Appropriate Azure permissions to create networking resources

## Usage

### Basic Example
```hcl
module "vnet" {
  source = "./path/to/module"

  global_location = "westeurope"
  global_rg      = "my-resource-group"
  vnet_name      = "my-vnet"
}
```

### Complete Example with Multiple Subnets
```hcl
module "vnet" {
  source = "./path/to/module"

  global_location = "westeurope"
  global_rg      = "my-resource-group"
  vnet_name      = "prod-vnet"
  
  vnet_address_space = ["10.0.0.0/16"]
  global_dns_servers = ["10.0.0.4", "10.0.0.5"]
  
  vnet_subnets = {
    subnet1 = {
      name             = "web-tier"
      address_prefixes = "10.0.1.0/24"
    },
    subnet2 = {
      name             = "app-tier"
      address_prefixes = "10.0.2.0/24"
    },
    subnet3 = {
      name             = "db-tier"
      address_prefixes = "10.0.3.0/24"
    }
  }

  global_tags = {
    Environment = "Production"
    Department  = "IT"
    Owner       = "Network Team"
  }
}
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| global_location | Azure region for deployment | string | n/a | yes |
| global_rg | Name of the resource group | string | n/a | yes |
| vnet_name | Name of the virtual network | string | n/a | yes |
| vnet_address_space | Address space for the VNet | list(string) | ["10.0.0.0/16"] | no |
| global_dns_servers | List of custom DNS servers | list(string) | [] | no |
| global_tags | Map of tags to apply to resources | map(string) | n/a | yes |
| vnet_subnets | Map of subnet configurations | map(object) | {} | no |

### Subnet Configuration Object

```hcl
vnet_subnets = {
  subnet_key = {
    name             = string
    address_prefixes = string
  }
}
```

## Outputs

| Name | Description |
|------|-------------|
| rg | The name of the resource group |
| vnet_name | The name of the created virtual network |
| location | The location/region of the virtual network |
| vnet_id | The resource ID of the virtual network |

## Best Practices

1. **Network Planning**
   - Plan your address space carefully to avoid overlapping
   - Use a consistent subnet sizing strategy
   - Consider future growth when allocating address spaces

2. **Subnet Organization**
   - Organize subnets by function (web, app, data)
   - Consider security boundaries
   - Plan for service integration (Azure services)

3. **DNS Configuration**
   - Use Azure DNS for cloud-native solutions
   - Plan custom DNS servers carefully
   - Document DNS configuration

4. **Security Considerations**
   - Plan Network Security Groups
   - Consider using Azure Firewall
   - Implement proper network segmentation

## Network Design Recommendations

1. **Address Space Planning**
   - Use RFC 1918 private address spaces
   - Plan for hybrid connectivity
   - Leave room for expansion

2. **Subnet Sizing**
   - Size subnets according to workload needs
   - Reserve space for Azure services
   - Plan for growth

3. **DNS Strategy**
   - Consider hybrid DNS requirements
   - Plan for private endpoints
   - Document DNS forwarding rules

## Example Subnet Patterns

### Three-Tier Architecture
```hcl
vnet_subnets = {
  web = {
    name             = "web-tier"
    address_prefixes = "10.0.1.0/24"
  },
  app = {
    name             = "app-tier"
    address_prefixes = "10.0.2.0/24"
  },
  data = {
    name             = "data-tier"
    address_prefixes = "10.0.3.0/24"
  }
}
```

### Microservices Architecture
```hcl
vnet_subnets = {
  frontend = {
    name             = "frontend"
    address_prefixes = "10.0.1.0/24"
  },
  services = {
    name             = "services"
    address_prefixes = "10.0.2.0/24"
  },
  data = {
    name             = "data"
    address_prefixes = "10.0.3.0/24"
  },
  management = {
    name             = "management"
    address_prefixes = "10.0.4.0/24"
  }
}
```

## Known Limitations

1. Subnet delegations must be managed separately
2. Network Security Groups are not included in this module
3. Route tables must be associated separately
4. Maximum of 65,536 IP addresses per VNet
5. Maximum of 3,000 subnets per VNet

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This module is licensed under the MIT License. See the LICENSE file for details.

---
**Note**: Always test your network configurations in a non-production environment first and ensure they align with your organization's networking policies.