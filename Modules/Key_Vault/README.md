# Azure Key Vault Terraform Module

This Terraform module creates an Azure Key Vault with configurable access policies, secrets, and private endpoint integration.

## Features

- Create Azure Key Vault with customizable configuration
- Configure access policies for users, applications, and service principals
- Manage Key Vault secrets
- Enable private endpoint integration
- Configure network access rules
- Support for tags
- Customizable retention policies and encryption settings

## Usage

```hcl
module "key_vault" {
  source = "path/to/module"

  kv_name             = "my-key-vault"
  location            = "westeurope"
  resource_group_name = "my-resource-group"
  
  # Optional: Configure SKU
  kv_sku_name = "standard"  # or "premium"
  
  # Optional: Configure access policies
  access_policies = [
    {
      object_id = "00000000-0000-0000-0000-000000000000"
      secret_permissions = ["Get", "List", "Set", "Delete"]
    }
  ]
  
  # Optional: Add secrets
  secrets = {
    "my-secret" = {
      value = "secret-value"
      tags  = { environment = "prod" }
    }
  }
  
  # Optional: Configure private endpoint
  private_endpoint = {
    name      = "kv-pe"
    subnet_id = "/subscriptions/.../subnets/subnet-id"
    private_dns_zone_ids = [
      "/subscriptions/.../privateDnsZones/privatelink.vaultcore.azure.net/id"
    ]
  }
  
  # Optional: Add tags
  tags = {
    environment = "production"
    managed_by  = "terraform"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| azurerm | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kv_name | Name of the Key Vault | `string` | n/a | yes |
| location | Azure region for Key Vault | `string` | n/a | yes |
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| kv_sku_name | SKU name for the Key Vault | `string` | `"standard"` | no |
| kv_enabled_for_disk_encryption | Enable disk encryption | `bool` | `true` | no |
| kv_purge_protection_enabled | Enable purge protection | `bool` | `true` | no |
| kv_soft_delete_retention_days | Soft delete retention days | `number` | `7` | no |
| kv_public_network_access_enabled | Enable public network access | `bool` | `false` | no |
| access_policies | List of access policy configurations | `list(object)` | `[]` | no |
| secrets | Map of secrets to create | `map(object)` | `{}` | no |
| private_endpoint | Private endpoint configuration | `object` | `null` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| key_vault_id | The ID of the Key Vault |
| key_vault_uri | The URI of the Key Vault |
| key_vault_name | The Name of the Key Vault |
| access_policies | The access policies created for the Key Vault |
| private_endpoint_id | The ID of the Private Endpoint |
| private_endpoint_ip_addresses | Private IP addresses of the Private Endpoint |
| private_endpoint_fqdn | The fully qualified domain name of the Private Endpoint |

## Private Endpoint Configuration

The module supports creating a private endpoint for the Key Vault. To enable private endpoint, provide the following configuration:

```hcl
private_endpoint = {
  name                        = "kv-pe-name"
  subnet_id                   = "/subscriptions/.../subnets/subnet-id"
  private_dns_zone_ids        = ["/subscriptions/.../privateDnsZones/privatelink.vaultcore.azure.net/id"]
  private_dns_zone_group_name = "default"
  is_manual_connection        = false
  tags                        = {}
}
```

## Access Policy Configuration

Access policies can be configured using the following format:

```hcl
access_policies = [
  {
    object_id = "00000000-0000-0000-0000-000000000000"
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete"
    ]
    certificate_permissions = [
      "Get",
      "List",
      "Create",
      "Delete"
    ]
  }
]
```

## Secret Management

Secrets can be managed using the following format:

```hcl
secrets = {
  "secret-name" = {
    value           = "secret-value"
    content_type    = "text/plain"
    tags            = { environment = "prod" }
    expiration_date = "2024-12-31T23:59:59Z"
  }
}
```