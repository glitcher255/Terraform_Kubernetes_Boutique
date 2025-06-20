// LOGGING
resource "azurerm_monitor_data_collection_rule" "main" {
  name                = "dcr"
  location            = var.location
  resource_group_name = var.rg_name
  kind                = "Linux"
  destinations {
    log_analytics {
      workspace_resource_id = var.workspace_id
      name                  = "destination_log"
    }
  }
  data_flow {
    streams                 = ["Microsoft-Perf", "Microsoft-Syslog"]
    destinations            = ["destination_log"]
  }
  data_sources {
    performance_counter {  //"Perf"(no insights)
      name               = "Perf_and_insights"
      sampling_frequency_in_seconds = 60
      streams            = ["Microsoft-Perf"]
      counter_specifiers = ["Processor(*)\\% Processor Time", "Processor(*)\\% User Time", "Logical Disk(*)\\% Free Space", "Memory(*)\\% Used Memory","Memory(*)\\Used Memory MBytes", "Network(*)\\Total Bytes",]
    }
     syslog {              //"Syslog"
       name           = "syslog_logging"
       facility_names = ["*"]
       streams        = ["Microsoft-Syslog"]
       log_levels     = [ "Alert", "Critical", "Debug", "Emergency", "Error", "Info", "Notice", "Warning" ]
     }
  }
#depends_on = [ the work log space ]
}

# resource "azurerm_monitor_data_collection_rule_association" "vm_assoc" {
#   name                    = "vm_dcr_association"
#   target_resource_id      = var.vm_id
#   data_collection_rule_id = azurerm_monitor_data_collection_rule.main.id
# }


#"AzureDiagnostics" logging
resource "azurerm_monitor_diagnostic_setting" "nsg_diag" {
  name = "nsg_diag"
  target_resource_id = var.nsg_id
  log_analytics_workspace_id = var.workspace_id
  enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
  }
}