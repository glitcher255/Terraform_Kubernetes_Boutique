resource "azurerm_log_analytics_workspace" "main" {
  name                = "log-workspace"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

#AMA INSTALL (must be created after VM - don't put in monitor)
# resource "azurerm_virtual_machine_scale_set_extension" "ama" {
#   name                         = "AzureMonitorLinuxAgent"
#   virtual_machine_scale_set_id = var.vm_id
#   publisher                   = "Microsoft.Azure.Monitor"
#   type                        = "AzureMonitorLinuxAgent"
#   type_handler_version        = "1.35"
# #   automatic_upgrade_enabled  = true
# #   auto_upgrade_minor_version = true
#   settings                    = "{}"
#   depends_on = [ azurerm_monitor_data_collection_rule_association.vm_assoc, azurerm_monitor_data_collection_rule.main ]
# }

# resource "azurerm_role_assignment" "log_analytics_contributor" {
#   scope                = azurerm_log_analytics_workspace.main.id
#   role_definition_name = "Log Analytics Contributor"
#   principal_id         = var.vm_identity
# }
# resource "azurerm_role_assignment" "metrics_publisher" {
#   scope                = azurerm_log_analytics_workspace.main.id
#   role_definition_name = "Monitoring Metrics Publisher"
#   principal_id         = var.vm_identity
# }
# resource "azurerm_role_assignment" "to_dcr" {
#   scope                = azurerm_monitor_data_collection_rule.main.id
#   role_definition_name = "Monitoring Metrics Publisher"
#   principal_id         = var.vm_identity
# }


# // LOGGING
# resource "azurerm_monitor_data_collection_rule" "main" {
#   name                = "dcr"
#   location            = var.location
#   resource_group_name = var.rg_name
#   kind                = "Linux"
#   destinations {
#     log_analytics {
#       workspace_resource_id = azurerm_log_analytics_workspace.main.id
#       name                  = "destination_log"
#     }
#   }
#   data_flow {
#     streams                 = ["Microsoft-Perf", "Microsoft-Syslog"]
#     destinations            = ["destination_log"]
#   }
#   data_sources {
#     performance_counter {  //"Perf"(no insights)
#       name               = "Perf_and_insights"
#       sampling_frequency_in_seconds = 60
#       streams            = ["Microsoft-Perf"]
#       counter_specifiers = ["Processor(*)\\% Processor Time",
#        "Processor(*)\\% User Time", "Logical Disk(*)\\% Free Space", "Network(*)\\Total Bytes Transmitted", "Network(*)\\Total Bytes Received", "Memory(*)\\% Used Memory","Memory(*)\\Used Memory MBytes", 
#       ]
#     }
#      syslog {              //"Syslog"
#        name           = "syslog_logging"
#        facility_names = ["*"]
#        streams        = ["Microsoft-Syslog"]
#        log_levels     = [ "Alert", "Critical", "Debug", "Emergency", "Error", "Info", "Notice", "Warning" ]
#      }
#   }
# #depends_on = [ azurerm_virtual_machine_scale_set_extension.ama ]
# }

# resource "azurerm_monitor_data_collection_rule_association" "vm_assoc" {
#   name                    = "vm_dcr_association"
#   target_resource_id      = var.vm_id
#   data_collection_rule_id = azurerm_monitor_data_collection_rule.main.id
# }


//??
# resource "azurerm_monitor_diagnostic_setting" "vm_diag" {
#   name = "vm_diag"
#   target_resource_id = var.vm_id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
#   metric {
#     category = "AllMetrics"
#     enabled = true
#   }
# }

#"AzureDiagnostics" logging
# resource "azurerm_monitor_diagnostic_setting" "nsg_diag" {
#   name = "nsg_diag"
#   target_resource_id = var.nsg_id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
#   enabled_log {
#     category = "NetworkSecurityGroupRuleCounter"
#   }
# }