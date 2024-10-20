output "as_id" {
  value = azurerm_app_service.app_service.id
}

output "as_name" {
  value = azurerm_app_service.app_service.name
}

output "as_location" {
  value = azurerm_app_service.app_service.location
}

output "as_rg" {
  value = azurerm_app_service.app_service.resource_group_name
}

output "asp_id" {
  value = azurerm_app_service.app_service.app_service_plan_id
}