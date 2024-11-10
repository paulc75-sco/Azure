# Azure Kubernetes Service (AKS) Terraform Module

This Terraform module deploys a production-ready Azure Kubernetes Service (AKS) cluster with best practices for security, scalability, and maintainability.

## Features

- 🔒 Security-hardened configuration with Azure AD integration and RBAC
- 🚀 Auto-scaling capabilities
- 🌐 Advanced networking with Azure CNI
- 🛡️ Network policies with Calico
- 🔄 Maintenance window configuration
- 📊 Built-in monitoring and logging support
- 🏢 High availability with availability zones
- ⚙️ Customizable node pool configuration

## Prerequisites

- Terraform >= 1.0.0
- Azure subscription
- Azure CLI installed and configured
- Permissions to create:
  - Azure Kubernetes Service clusters
  - Virtual Networks
  - Managed Identities
  - Role assignments

## Usage

```hcl
module "aks" {
  source = "./path/to/module"

  # Required variables
  aks_name           = "my-aks-cluster"
  global_location    = "eastus2"
  global_rg_name     = "my-resource-group"
  aks_dns_prefix     = "myakscluster"
  aks_dnp_name       = "default"
  aks_dnp_vm_size    = "Standard_D2s_v3"
  aks_vnet_subnet_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Network/virtualNetworks/.../subnets/..."
  aks_version        = "1.26.0"
  
  # Network configuration
  aks_np_service_cidr   = "10.0.0.0/16"
  aks_np_dns_service_ip = "10.0.0.10"
  
  # Optional configurations with defaults
  aks_dnp_node_count          = 1
  aks_max_count               = 5
  aks_min_count               = 1
  aks_dnp_auto_scaling_enabled = true
  aks_dnp_zones               = ["1", "2", "3"]
  aks_dnp_os_disk_size_gb     = 128
  aks_dnp_os_disk_type        = "Managed"
  
  # Maintenance window
  aks_mw_day  = "Sunday"
  aks_mw_hour = [0, 1, 2, 3, 4]
  
  # Tags
  global_tags = {
    Environment = "Production"
    Owner       = "Platform Team"
    CostCenter  = "IT-123"
  }
}
```

## Examples

### Basic Cluster

```hcl
module "aks_basic" {
  source = "./path/to/module"

  aks_name           = "basic-cluster"
  global_location    = "eastus2"
  global_rg_name     = "my-rg"
  aks_dns_prefix     = "basic"
  aks_dnp_name       = "default"
  aks_dnp_vm_size    = "Standard_D2s_v3"
  aks_vnet_subnet_id = azurerm_subnet.aks.id
  aks_version        = "1.26.0"
  
  aks_np_service_cidr   = "10.0.0.0/16"
  aks_np_dns_service_ip = "10.0.0.10"
}
```

### Production Cluster with High Availability

```hcl
module "aks_prod" {
  source = "./path/to/module"

  aks_name           = "prod-cluster"
  global_location    = "eastus2"
  global_rg_name     = "prod-rg"
  aks_dns_prefix     = "prod"
  aks_dnp_name       = "default"
  aks_dnp_vm_size    = "Standard_D4s_v3"
  aks_vnet_subnet_id = azurerm_subnet.aks_prod.id
  aks_version        = "1.26.0"
  
  aks_dnp_node_count          = 3
  aks_max_count               = 10
  aks_min_count               = 3
  aks_dnp_auto_scaling_enabled = true
  aks_dnp_zones               = ["1", "2", "3"]
  
  aks_np_service_cidr   = "10.0.0.0/16"
  aks_np_dns_service_ip = "10.0.0.10"
  
  global_tags = {
    Environment = "Production"
    CostCenter  = "IT-123"
    Critical    = "Yes"
  }
}
```

## Required Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| aks_name | Name of the AKS cluster | string | yes |
| global_location | Azure region for deployment | string | yes |
| global_rg_name | Resource group name | string | yes |
| aks_dns_prefix | DNS prefix for the cluster | string | yes |
| aks_dnp_name | Default node pool name | string | yes |
| aks_dnp_vm_size | VM size for nodes | string | yes |
| aks_vnet_subnet_id | Subnet ID for the node pool | string | yes |
| aks_version | Kubernetes version | string | yes |
| aks_np_service_cidr | CIDR for Kubernetes services | string | yes |
| aks_np_dns_service_ip | DNS service IP address | string | yes |

## Optional Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| aks_dnp_node_count | Initial node count | number | 1 |
| aks_max_count | Maximum node count | number | 5 |
| aks_min_count | Minimum node count | number | 1 |
| aks_dnp_auto_scaling_enabled | Enable auto-scaling | bool | true |
| aks_dnp_zones | Availability zones | list(string) | ["1", "2", "3"] |
| aks_dnp_os_disk_size_gb | OS disk size in GB | number | 128 |
| aks_dnp_os_disk_type | OS disk type | string | "Managed" |
| aks_mw_day | Maintenance window day | string | "Sunday" |
| aks_mw_hour | Maintenance window hours | list(number) | [0, 1, 2, 3, 4] |
| global_tags | Resource tags | map(string) | {} |

## Outputs

| Name | Description |
|------|-------------|
| client_certificate | Base64 encoded public certificate for client authentication |
| kube_config | Raw Kubernetes config for cluster access |
| cluster_identity | Principal ID of the cluster's managed identity |
| kubelet_identity | Object ID of the kubelet's managed identity |
| node_resource_group | Name of the node resource group |

## Best Practices

1. **Networking**
   - Use Azure CNI for advanced networking features
   - Configure network policies for pod-to-pod traffic control
   - Use private clusters in production environments

2. **Security**
   - Enable Azure AD integration
   - Use RBAC for access control
   - Regularly update Kubernetes version
   - Implement network policies

3. **Scalability**
   - Enable auto-scaling
   - Use availability zones for high availability
   - Configure appropriate node sizes

4. **Monitoring**
   - Enable Azure Monitor for containers
   - Configure log analytics workspace
   - Set up alerts for critical metrics

## Known Issues

- None currently documented

## Contributing

Please refer to the contribution guidelines for submitting improvements.

## License

This module is licensed under the MIT License. See the LICENSE file for details.