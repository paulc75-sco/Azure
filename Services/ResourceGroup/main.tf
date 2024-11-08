resource "azurerm_resource_group" "resourcegroup" {
  name     = var.global_name
  location = var.global_location

  tags = {
    Name        = var.global_name
    Location    = var.global_location
    Environment = var.global_environment
    Group       = var.global_group
    Owner       = var.global_owner

  }

}
