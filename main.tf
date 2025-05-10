resource "azurerm_resource_group" "rg_main" {
  name     = "RG_main"
  location = var.location
}

module "vnet" {
  source   = "./modules/vnet"
  location = var.location
  rg_name  = azurerm_resource_group.rg_main.name
  depends_on = [ azurerm_resource_group.rg_main ]
}

module "vm" {
  source   = "./modules/vm"
  location = var.location
  rg_name  = azurerm_resource_group.rg_main.name
  subnet_id       = module.vnet.subnet_id
  backend_pool_id = module.load_balancer.backend_pool_id
  depends_on      = [ module.vnet, module.load_balancer ]
}

module "nsg" {
  source   = "./modules/NSG"
  location = var.location
  rg_name  = azurerm_resource_group.rg_main.name
  subnet_id  = module.vnet.subnet_id
  depends_on = [ module.vnet ]
}

# resource "time_sleep" "wait_30_seconds" {
#   create_duration = "300s"
# }
module "monitoring" {
  source   = "./modules/monitoring"
  location = var.location
  rg_name  = azurerm_resource_group.rg_main.name
  vm_id      = module.vm.vm_id
  nsg_id     = module.nsg.nsg_id
  vm_identity = module.vm.vm_identity
  #depends_on = [  azurerm_resource_group.rg_main ]
}

module "load_balancer" {
  source   = "./modules/load_balancer"
  location = var.location
  rg_name  = azurerm_resource_group.rg_main.name
  depends_on = [ module.vnet ]
}

module "dcr" {
  source = "./modules/dcr"
  location = var.location
  rg_name = azurerm_resource_group.rg_main.name
  vm_id = module.vm.vm_id
  workspace_id = module.monitoring.workspace_id
  depends_on = [ module.monitoring, module.vm ]
}