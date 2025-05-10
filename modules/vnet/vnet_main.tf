resource "azurerm_virtual_network" "v_network" {
    name                = "v_network"
    location            = var.location
    resource_group_name = var.rg_name
    address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet_1" {
  name = "subnet_1"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.v_network.name
  address_prefixes     = ["10.0.1.0/24"]
}