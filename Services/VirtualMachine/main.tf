resource "azurerm_public_ip" "PublicIp" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = var.allocation_method

}

resource "azurerm_network_interface" "NIC" {
  name                = var.name
  location            = var.location
  resource_group_name = azurerm_public_ip.PublicIp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.allocation_method
    public_ip_address_id          = azurerm_public_ip.PublicIp.id
  }


}

resource "azurerm_linux_virtual_machine" "VirtualMachine" {
  name                  = var.name
  resource_group_name   = var.resource_group
  location              = var.location
  size                  = var.vmsize
  admin_username        = var.username
  network_interface_ids = azurerm_network_interface.NIC.id

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  admin_ssh_key {
    username   = var.username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {

    publisher = var.publisher
    offer     = var.publisher
    sku       = var.sku
    version   = var.imageversion

  }
}
