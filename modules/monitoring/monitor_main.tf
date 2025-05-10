resource "azurerm_log_analytics_workspace" "main" {
  name                = "log-workspace"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}