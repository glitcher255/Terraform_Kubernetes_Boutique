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

module "namespaces" {
  source      = "./modules/namespaces"
  depends_on  = [module.vm]
}

module "monitoring" {
  source               = "./modules/monitoring"
  monitoring_namespace = module.namespaces.monitoring_namespace
  kube_config          = module.vm.kube_config
  depends_on           = [module.namespaces, module.vm] ##added module.vm
}


#certificate instead of running "az aks get-credentials --resource-group RG_main --name AKS_cluster --overwrite-existing"
provider "kubernetes" {
  host                   = module.vm.kube_config.host
  client_certificate     = base64decode(module.vm.kube_config.client_certificate)
  client_key             = base64decode(module.vm.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.vm.kube_config.cluster_ca_certificate)
}

provider "helm" {
  kubernetes = {
      host                   = module.vm.kube_config.host
  client_certificate     = base64decode(module.vm.kube_config.client_certificate)
  client_key             = base64decode(module.vm.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.vm.kube_config.cluster_ca_certificate)
  }
}