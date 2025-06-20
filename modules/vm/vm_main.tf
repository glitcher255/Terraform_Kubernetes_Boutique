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