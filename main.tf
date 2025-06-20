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
  depends_on      = [ module.vnet]
}

module "nsg" {
  source   = "./modules/NSG"
  location = var.location
  rg_name  = azurerm_resource_group.rg_main.name
  subnet_id  = module.vnet.subnet_id
  depends_on = [ module.vnet ]
}