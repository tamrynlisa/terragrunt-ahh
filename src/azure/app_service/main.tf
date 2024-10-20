resource "azurerm_app_service" "app_service" {
  id                  = var.id
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id
}