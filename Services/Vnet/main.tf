resource "azurerm_resource_group" "vnetdemopc" {
  name     = var.resource_group_name
  location = var.location

}


resource "azurerm_virtual_network" "vnetdemopc" {
  name                = azurerm_resource_group.vnetdemopc.name
  location            = azurerm_resource_group.vnetdemopc.location
  resource_group_name = azurerm_resource_group.vnetdemopc.name
  address_space       = var.address_space

  subnet {
    name             = "dev_subnet"
    address_prefixes = ["10.0.0.0/24"]

  }

  subnet {
    name             = "test_subnet"
    address_prefixes = ["10.0.1.0/24"]

  }

  subnet {
    name             = "production_subnet"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.vnetdemo.id
  }

}


resource "azurerm_network_security_group" "vnetdemo" {
  name                = azurerm_resource_group.vnetdemopc.name
  location            = azurerm_resource_group.vnetdemopc.location
  resource_group_name = azurerm_resource_group.vnetdemopc.name

}
