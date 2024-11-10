resource "azurerm_resource_group" "resource_group" {
  name     = var.name
  location = var.location
  tags     = var.tags

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      tags["Created By"]
    ]
  }

}
