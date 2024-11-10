output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.storagedemo.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storagedemo.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint"
  value       = azurerm_storage_account.storagedemo.primary_blob_endpoint
}

output "container_name" {
  description = "The name of the storage container"
  value       = azurerm_storage_container.storagedemo.name
}

output "primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.storagedemo.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for the storage account"
  value       = azurerm_storage_account.storagedemo.secondary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string for the storage account"
  value       = azurerm_storage_account.storagedemo.primary_connection_string
  sensitive   = true
}
