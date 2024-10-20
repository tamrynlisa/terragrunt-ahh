resource "azurerm_app_service_plan" "asp_linux" {
  id                  = var.id
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.kind

  sku {
    tier = "Free"
    size = "F1"
  }

  reserved = true # This makes it a Linux plan
}
