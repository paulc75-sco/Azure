resource "azurerm_resource_group" "resourcegroup" {
  name     = var.global_name
  location = var.global_location
  tags     = var.global_tags



}
