output "deployed_vms" {
  description = "Récapitulatif des VMs déployées (Nom, ID, IP)"
  value = {
    for k, vm in proxmox_virtual_environment_vm.vm : k => {
      id   = vm.id
      name = vm.name
      ip   = var.vms[k].ip_address
    }
  }
}
