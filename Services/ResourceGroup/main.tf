resource "azurerm_resource_group" "resourcegroup" {
  name     = var.name
  location = var.location

  tags = {
    Name        = var.name
    Location    = var.location
    Environment = var.environment
    Group       = var.group
    Owner       = var.owner

  }

}
