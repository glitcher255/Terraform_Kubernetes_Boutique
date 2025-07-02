# output "vm_id" {
#   value = azurerm_linux_virtual_machine_scale_set.linux_vm.id
# }


# output "vm_identity" {
#   value = azurerm_linux_virtual_machine_scale_set.linux_vm.identity[0].principal_id
# }


#critical for providers.tf
output "kube_config" {
    value = azurerm_kubernetes_cluster.aks.kube_config[0]
}