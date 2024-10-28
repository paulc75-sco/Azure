resource "azurerm_resource_group" "resourcegroup" {
  name     = var.name
  location = var.location

  tags = merge(var.tags)

}
