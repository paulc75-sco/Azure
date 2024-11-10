# Azure Storage Account Terraform Module

This Terraform configuration creates an Azure Storage Account with enhanced security features, network rules, and blob properties. The configuration includes a resource group (created via a separate module) and a storage container.

## Features

- Infrastructure encryption enabled
- TLS 1.2 enforcement
- HTTPS-only traffic
- Network access rules (IP and VNet-based)
- Blob versioning
- Delete retention policies
- Change feed tracking
- Comprehensive output variables

## Prerequisites

- Terraform >= 1.0.0
- Azure Subscription
- Azure CLI or appropriate Service Principal credentials
- Access to the Resource Group module (`../../Modules/Resource_Group_V2`)

## Required Providers

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
}
```

## Usage

1. Clone the repository
2. Navigate to the directory containing the Terraform configuration
3. Create a `terraform.tfvars` file with your specific values
4. Initialize Terraform:
   ```bash
   terraform init
   ```
5. Review the plan:
   ```bash
   terraform plan
   ```
6. Apply the configuration:
   ```bash
   terraform apply
   ```

### Example terraform.tfvars

```hcl
name           = "storageaccountdemo"
container_name = "data"
tags = {
  environment = "Pre Prod"
  group       = "IT"
  owner       = "John Doe"
}
subscription_id = "your-subscription-id"
allowed_ip_ranges = ["203.0.113.0/24"]
subnet_ids = ["/subscriptions/.../resourceGroups/.../providers/Microsoft.Network/virtualNetworks/.../subnets/..."]
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Storage account name (3-24 chars, lowercase letters and numbers only) | `string` | n/a | yes |
| location | Azure region for resources | `string` | `"West Europe"` | no |
| account_tier | Storage account tier | `string` | `"Standard"` | no |
| account_replication_type | Replication type | `string` | `"LRS"` | no |
| container_name | Name of the storage container | `string` | n/a | yes |
| container_access_type | Container access level | `string` | `"private"` | no |
| tags | Resource tags | `map(string)` | n/a | yes |
| subscription_id | Azure subscription ID | `string` | n/a | yes |
| allowed_ip_ranges | List of allowed IP ranges | `list(string)` | `[]` | no |
| subnet_ids | List of allowed subnet IDs | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| storage_account_id | The ID of the storage account |
| storage_account_name | The name of the storage account |
| primary_blob_endpoint | The primary blob endpoint |
| container_name | The name of the storage container |
| primary_access_key | The primary access key (sensitive) |
| secondary_access_key | The secondary access key (sensitive) |
| primary_connection_string | The primary connection string (sensitive) |

## Security Features

- **Infrastructure Encryption**: Enabled by default
- **TLS Version**: Enforced to 1.2
- **Network Rules**: 
  - Default deny all access
  - Configurable IP allowlist
  - VNet integration support
  - Azure Services bypass option
- **Blob Properties**:
  - Versioning enabled
  - 7-day delete retention
  - 7-day container delete retention
  - Change feed tracking

## Best Practices

1. Always use private access for containers unless public access is specifically required
2. Configure allowed IP ranges and subnet IDs based on principle of least privilege
3. Regularly rotate access keys
4. Monitor storage metrics and logs
5. Use appropriate replication type based on availability requirements
6. Tag all resources appropriately for cost allocation and management

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## Notes

- The resource group is created using a separate module (`Resource_Group_V2`)
- All sensitive outputs are marked as sensitive in Terraform
- Default values are provided for most optional parameters