# resource "azurerm_linux_virtual_machine_scale_set" "linux_vm" {
#   name                = "linuxVM"
#   location            = var.location
#   resource_group_name = var.rg_name
#   sku                 = "Standard_B1s"
#   instances           = 1
#   admin_username      = "adminuser"
#   custom_data = base64encode(file("cloud-init.yml"))
# admin_ssh_key {
#   username = "adminuser"
#   public_key = file("id_rsa.pub")
# }
# os_disk {
#   caching = "ReadWrite"
#   storage_account_type = "Standard_LRS"
# }
# source_image_reference {
#   publisher = "Canonical"
#   offer = "ubuntu-24_04-lts"
#   sku = "server"
#   version = "latest"
# }
# network_interface {
#   name    = "vm_nic"
#   primary = true
#   ip_configuration {
#     name                                   = "vm_ip"
#     primary                                = true
#     subnet_id                              = var.subnet_id
#     load_balancer_backend_address_pool_ids = [var.backend_pool_id]
#   }
# }

# #AMA INSTALL
# extension {
#   name                 = "AzureMonitorLinuxAgent"
#   publisher            = "Microsoft.Azure.Monitor"
#   type                 = "AzureMonitorLinuxAgent"
#   type_handler_version = "1.35"
#   settings             = jsonencode({})
# }
# identity {
#   type = "SystemAssigned"
# }
# }


resource "azurerm_kubernetes_cluster" "aks" {
  name                = "AKS_cluster"
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "myaks"

  default_node_pool {
    name                = "default"
    vm_size             = "Standard_DS2_v2"
    auto_scaling_enabled  = true
    min_count           = 1
    max_count           = 3
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id = var.subnet_id
  }
    identity {
    type = "SystemAssigned"
  }
}


////////// AUTO SCALING ///
# resource "azurerm_monitor_autoscale_setting" "autoscale" {
#   name                = "vmss_autoscale"
#   resource_group_name = var.rg_name
#   location            = var.location
#   target_resource_id  = azurerm_linux_virtual_machine_scale_set.linux_vm.id
#   enabled             = true
#   profile {
#     name = "autoscale-profile"
#     capacity {
#       minimum = 1
#       maximum = 3
#       default = 1
#     }
#     rule {
#       metric_trigger {
#         metric_name        = "Percentage CPU"
#         metric_resource_id = azurerm_linux_virtual_machine_scale_set.linux_vm.id
#         time_grain         = "PT1M"
#         statistic          = "Average"
#         time_window        = "PT5M"
#         time_aggregation   = "Average"
#         operator           = "GreaterThan"
#         threshold          = 70
#       }
#       scale_action {
#         direction = "Increase"
#         type      = "ChangeCount"
#         value     = "1"
#         cooldown  = "PT5M"
#       }
#     }
#     rule {
#       metric_trigger {
#         metric_name        = "Percentage CPU"
#         metric_resource_id = azurerm_linux_virtual_machine_scale_set.linux_vm.id
#         time_grain         = "PT1M"
#         statistic          = "Average"
#         time_window        = "PT5M"
#         time_aggregation   = "Average"
#         operator           = "LessThan"
#         threshold          = 30
#       }
#       scale_action {
#         direction = "Decrease"
#         type      = "ChangeCount"
#         value     = "1"
#         cooldown  = "PT10M"
#       }
#     }
#   }
# }