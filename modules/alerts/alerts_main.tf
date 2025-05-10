resource "azurerm_monitor_action_group" "main" {
  name = "action_group"
  resource_group_name = var.rg_name
  short_name = "actgrp"
  email_receiver {
    name = "main_email"
    email_address = "example@gmail.com"
    use_common_alert_schema = true
  }
}


//Query based Alert logging (AMA)
resource "azurerm_monitor_scheduled_query_rules_alert" "high_cpu" {
  name = "high_cpu_alert_log"
  location = var.location
  resource_group_name = var.rg_name
  description = "Alert when CPU > 80%"
  enabled = true
  frequency = 5
  time_window = 5
  severity = 0
  data_source_id = var.workspace_id
  query = <<QUERY
Perf
| where ObjectName == "Processor" and CounterName == "% User Time" and InstanceName == "total"
| summarize AvgCPU = avg(CounterValue) by bin(TimeGenerated, 5m)
| where AvgCPU > 80
QUERY
  action {
    action_group = [azurerm_monitor_action_group.main.id]
  }
  trigger {  // ignored for log alerts
    operator = "GreaterThan"
    threshold = 0
  }
}


//METRIC ALERTS (no AMA)
resource "azurerm_monitor_metric_alert" "high_cpu" {
  name = "high_CPU_alert_metric"
  resource_group_name = var.rg_name
  severity = 2
  scopes = [ var.vm_id ]
  enabled = true

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
    metric_name = "Percentage CPU"
    aggregation = "Average"
    operator = "GreaterThan"
    threshold = 80
  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}