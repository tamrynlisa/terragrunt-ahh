resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.region
  tags     = var.tags
}
