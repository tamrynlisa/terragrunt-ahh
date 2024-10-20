resource "azurerm_storage_account" "storage" {
  id                       = var.id
  name                     = var.name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  resource_group_name      = var.rg
  location                 = var.location
}