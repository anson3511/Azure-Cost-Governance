data "azurerm_subscription" "current" {}

resource "azurerm_monitor_action_group" "dev_ag" {
  name                = "ag-dev-cost-alert"
  resource_group_name = azurerm_resource_group.dev.name
  short_name          = "devcost"

  email_receiver {
    name          = "dev-manager"
    email_address = var.dev_email
  }
}

resource "azurerm_monitor_action_group" "test_ag" {
  name                = "ag-test-cost-alert"
  resource_group_name = azurerm_resource_group.test.name
  short_name          = "testcost"

  email_receiver {
    name          = "test-manager"
    email_address = var.test_email
  }
}

resource "azurerm_monitor_action_group" "prod_ag" {
  name                = "ag-prod-cost-alert"
  resource_group_name = azurerm_resource_group.prod.name
  short_name          = "prodcost"

  email_receiver {
    name          = "prod-manager"
    email_address = var.prod_email
  }
}

resource "azurerm_consumption_budget_resource_group" "dev_budget" {
  name              = "dev-monthly-budget"
  resource_group_id = azurerm_resource_group.dev.id
  amount            = 50
  time_grain        = "Monthly"

  time_period {
    start_date = "2026-06-01T00:00:00Z"
    end_date   = "2027-06-01T00:00:00Z"
  }

  notification {
    enabled        = true
    threshold      = 80
    operator       = "GreaterThan"
    threshold_type = "Actual"

    contact_emails = [var.dev_email]
    contact_groups = [azurerm_monitor_action_group.dev_ag.id]
  }
}

resource "azurerm_consumption_budget_resource_group" "test_budget" {
  name              = "test-monthly-budget"
  resource_group_id = azurerm_resource_group.test.id
  amount            = 75
  time_grain        = "Monthly"

  time_period {
    start_date = "2026-06-01T00:00:00Z"
    end_date   = "2027-06-01T00:00:00Z"
  }

  notification {
    enabled        = true
    threshold      = 80
    operator       = "GreaterThan"
    threshold_type = "Actual"

    contact_emails = [var.test_email]
    contact_groups = [azurerm_monitor_action_group.test_ag.id]
  }
}

resource "azurerm_consumption_budget_resource_group" "prod_budget" {
  name              = "prod-monthly-budget"
  resource_group_id = azurerm_resource_group.prod.id
  amount            = 100
  time_grain        = "Monthly"

  time_period {
    start_date = "2026-06-01T00:00:00Z"
    end_date   = "2027-06-01T00:00:00Z"
  }

  notification {
    enabled        = true
    threshold      = 80
    operator       = "GreaterThan"
    threshold_type = "Actual"

    contact_emails = [var.prod_email]
    contact_groups = [azurerm_monitor_action_group.prod_ag.id]
  }
}