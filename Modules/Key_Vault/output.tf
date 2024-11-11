output "key_vault_id" {
  value       = azurerm_key_vault.key_vault.id
  description = "The ID of the Key Vault"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.key_vault.vault_uri
  description = "The URI of the Key Vault"
}

output "key_vault_name" {
  value       = azurerm_key_vault.key_vault.name
  description = "The Name of the Key Vault"
}

output "access_policies" {
  value       = azurerm_key_vault_access_policy.policies
  description = "The access policies created for the Key Vault"
  sensitive   = true
}

# Add to outputs.tf
output "private_endpoint_id" {
  description = "The ID of the Private Endpoint"
  value       = try(azurerm_private_endpoint.keyvault[0].id, null)
}

output "private_endpoint_ip_addresses" {
  description = "Private IP addresses of the Private Endpoint"
  value       = try(azurerm_private_endpoint.keyvault[0].private_service_connection[0].private_ip_address, null)
}

output "private_endpoint_fqdn" {
  description = "The fully qualified domain name of the Private Endpoint"
  value       = try(azurerm_private_endpoint.keyvault[0].custom_dns_configs[0].fqdn, null)
}
