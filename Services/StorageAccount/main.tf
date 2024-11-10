#Terraform to create a storage account
module "resourcegroup" {
  source          = "../../Modules/Resource_Group_V2"
  global_name     = var.name
  global_location = var.location
  global_tags     = var.tags
}

resource "azurerm_storage_account" "storagedemo" {
  name                              = module.resourcegroup.rg
  resource_group_name               = module.resourcegroup.rg
  location                          = module.resourcegroup.location
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  infrastructure_encryption_enabled = true
  min_tls_version                   = "TLS1_2"
  https_traffic_only_enabled        = true

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = var.allowed_ip_ranges
    virtual_network_subnet_ids = var.subnet_ids
  }

  blob_properties {

    versioning_enabled = true
    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }

    change_feed_enabled = true
  }
}

resource "azurerm_storage_container" "storagedemo" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storagedemo.name
  container_access_type = var.container_access_type

}
