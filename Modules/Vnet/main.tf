resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.global_location
  resource_group_name = var.global_rg
  address_space       = var.vnet_address_space
  dns_servers         = var.global_dns_servers
  tags                = var.global_tags

  dynamic "subnet" {
    for_each = var.vnet_subnets
    content {

      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }

  }
}
