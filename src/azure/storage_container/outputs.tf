output "st_cont_name" {
  value = azurerm_storage_container.storage_container.name
}

output "st_acc_name" {
  value = azurerm_storage_container.storage_container.storage_account_name
}

output "st_cont_access_type" {
  value = azurerm_storage_container.storage_container.container_access_type
}