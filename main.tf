resource "azurerm_resource_group" "dev" {
  name     = "rg-dev-cost"
  location = var.location
}

resource "azurerm_resource_group" "test" {
  name     = "rg-test-cost"
  location = var.location
}

resource "azurerm_resource_group" "prod" {
  name     = "rg-prod-cost"
  location = var.location
}