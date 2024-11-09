output "rg" {
  value = var.global_rg
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "location" {
  value = var.global_location
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
