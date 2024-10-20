output "st_id" {
  value = azurerm_storage_account.storage.id
}

output "st_name" {
  value = azurerm_storage_account.storage.name
}

output "st_account_tier" {
  value = azurerm_storage_account.storage.account_tier
}

output "st_account_replication_type" {
  value = azurerm_storage_account.storage.account_replication_type
}

output "rg_name" {
  value = azurerm_storage_account.storage.resource_group_name
}

output "st_location" {
  value = azurerm_storage_account.storage.location
}