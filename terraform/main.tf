resource "proxmox_virtual_environment_vm" "vm" {
  for_each = var.vms

  name        = each.value.name
  node_name   = var.target_node
  vm_id       = each.value.vm_id
  description = each.value.description

  clone {
    vm_id = var.debian_template_id
  }

  cpu {
    cores = each.value.cores
    type  = "host"
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = each.value.disk_size
    file_format  = "raw"
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    user_account {
      username = "ansible"
      keys     = [var.ssh_public_key]
    }
    ip_config {
      ipv4 {
        address = each.value.ip_address
        gateway = var.gateway
      }
    }
  }
}
