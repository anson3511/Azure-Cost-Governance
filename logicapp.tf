resource "azurerm_logic_app_workflow" "cost_alert_logicapp" {
  name                = "cost-alert-logicapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
