output "vm_id" {
  value = azurerm_linux_virtual_machine_scale_set.linux_vm.id
}


output "vm_identity" {
  value = azurerm_linux_virtual_machine_scale_set.linux_vm.identity[0].principal_id
}