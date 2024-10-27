#Terraform to create a storage account
resource "azurerm_resource_group" "storagedemo" {
  name     = var.name
  location = var.location

}

resource "azurerm_storage_account" "storagedemo" {
  name                     = azurerm_resource_group.storagedemo.name
  resource_group_name      = azurerm_resource_group.storagedemo.name
  location                 = azurerm_resource_group.storagedemo.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "storagedemo" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storagedemo.name
  container_access_type = var.container_access_type

}
