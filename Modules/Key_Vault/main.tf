resource "azurerm_key_vault" "key_vault" {
  name                          = var.kv_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku_name                      = var.kv_sku_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption   = var.kv_enabled_for_disk_encryption
  purge_protection_enabled      = var.kv_purge_protection_enabled
  soft_delete_retention_days    = var.kv_soft_delete_retention_days
  public_network_access_enabled = var.kv_public_network_access_enabled
  enable_rbac_authorization     = false
  tags                          = var.tags

}

resource "azurerm_key_vault_access_policy" "policies" {
  for_each = { for idx, policy in var.access_policies : idx => policy }

  key_vault_id   = azurerm_key_vault.key_vault.id
  tenant_id      = data.azurerm_client_config.current.tenant_id
  object_id      = each.value.object_id
  application_id = each.value.application_id

  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
  storage_permissions     = each.value.storage_permissions

}

resource "azurerm_key_vault_secret" "secrets" {
  for_each = var.secrets

  name         = each.key
  value        = each.value.value
  key_vault_id = azurerm_key_vault.key_vault.id

  content_type    = each.value.content_type
  tags            = each.value.tags
  expiration_date = each.value.expiration_date
  not_before_date = each.value.not_before_date

  depends_on = [azurerm_key_vault_access_policy.policies]
}


resource "azurerm_private_endpoint" "keyvault" {
  count               = var.private_endpoint != null ? 1 : 0
  name                = var.private_endpoint.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint.subnet_id
  tags                = merge(var.tags, var.private_endpoint.tags)

  private_service_connection {
    name                           = "${var.private_endpoint.name}-connection"
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    is_manual_connection           = var.private_endpoint.is_manual_connection
    subresource_names              = ["vault"]
  }

  dynamic "private_dns_zone_group" {
    for_each = length(var.private_endpoint.private_dns_zone_ids) > 0 ? [1] : []
    content {
      name                 = var.private_endpoint.private_dns_zone_group_name
      private_dns_zone_ids = var.private_endpoint.private_dns_zone_ids
    }
  }

  lifecycle {
    precondition {
      condition     = var.private_endpoint.is_manual_connection == false
      error_message = "Manual connection for private endpoint is not supported for Key Vault."
    }
  }
}
