module "resource_group" {
  source = "../../Modules/Resource_Group"
  name   = var.name

}

resource "azurerm_virtual_network" "vnetdemopc" {
  name                = module.resource_group.name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
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
  name                = module.resource_group.name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

}
