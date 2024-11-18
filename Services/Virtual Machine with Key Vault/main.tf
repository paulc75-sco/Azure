resource "azurerm_resource_group" "resource_group" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_key_vault" "key_vault" {
  name                = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set"
  ]

}
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"

}

resource "azurerm_key_vault_secret" "ssh_private_key" {
  depends_on   = [azurerm_key_vault_access_policy.key_vault_access_policy, time_sleep.ssh_private_key_delay]
  name         = "ssh-private-key"
  value        = tls_private_key.ssh.private_key_pem
  key_vault_id = azurerm_key_vault.key_vault.id

  timeouts {
    create = "60m"
  }

}

resource "time_sleep" "ssh_private_key_delay" {
  depends_on      = [azurerm_key_vault_access_policy.key_vault_access_policy]
  create_duration = "2m"

}


resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefix


}


resource "azurerm_network_interface" "nic" {
  name                = var.nicname
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {

    name                          = var.ip_config_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.ip_allocation
  }

}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                = var.vmname
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  size                = var.vmsize
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  admin_ssh_key {

    username   = var.admin_username
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.vm_version
  }

}
