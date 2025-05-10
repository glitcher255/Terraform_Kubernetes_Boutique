resource "azurerm_lb" "lb" {
  name                = "load_balancer"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "frontend_config"
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }
}

resource "azurerm_public_ip" "lb_ip" {
  name                = "load_balancer_ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb_backend_address_pool" "lb_pool" {
  name                = "lb_backend_pool"
  loadbalancer_id     = azurerm_lb.lb.id
}

//health checks
resource "azurerm_lb_probe" "http_probe" {
  name                = "flame-http-probe"
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
  loadbalancer_id     = azurerm_lb.lb.id
}
//need to open all ports
resource "azurerm_lb_rule" "http" {
  name                           = "http_rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend_config"
  probe_id                       = azurerm_lb_probe.http_probe.id
  loadbalancer_id                = azurerm_lb.lb.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_pool.id]
}
resource "azurerm_lb_rule" "ssh" {
  name                           = "ssh_rule"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = "frontend_config"
  #probe_id                       = ??
  loadbalancer_id                = azurerm_lb.lb.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_pool.id]
}
resource "azurerm_lb_rule" "flame" {
  name                           = "flame_rule"
  protocol                       = "Tcp"
  frontend_port                  = 5005
  backend_port                   = 5005
  frontend_ip_configuration_name = "frontend_config"
  #probe_id                       = ??
  loadbalancer_id                = azurerm_lb.lb.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_pool.id]
}
//// Ports end