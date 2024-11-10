resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.aks_version

  default_node_pool {
    name                 = var.aks_dnp_name
    node_count           = var.aks_dnp_node_count
    vm_size              = var.aks_dnp_vm_size
    max_count            = var.aks_max_count
    min_count            = var.aks_min_count
    vnet_subnet_id       = var.aks_vnet_subnet_id
    auto_scaling_enabled = var.aks_dnp_auto_scaling_enabled
    zones                = var.aks_dnp_zones
    os_disk_size_gb      = var.aks_dnp_os_disk_size_gb
    os_disk_type         = var.aks_dnp_os_disk_type
    tags                 = var.tags

  }

  identity {
    type = var.aks_identity_type
  }

  network_profile {
    network_plugin    = var.aks_np_network_plugin
    network_policy    = var.aks_np_network_policy
    load_balancer_sku = var.aks_np_load_balancer_sku
    service_cidr      = var.aks_np_service_cidr
    dns_service_ip    = var.aks_np_dns_service_ip

  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true

  }

  role_based_access_control_enabled = true

  maintenance_window {

    allowed {

      day   = var.aks_mw_day
      hours = var.aks_mw_hour
    }
  }

  tags = var.tags


}
