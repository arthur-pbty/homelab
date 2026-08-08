resource "proxmox_virtual_environment_vm" "vm" {
  for_each = var.vms

  name        = each.value.name
  node_name   = var.target_node
  vm_id       = each.value.vm_id
  description = each.value.description
  tags        = each.value.tags

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
    datastore_id = each.value.datastore
    interface    = "scsi0"
    size         = each.value.disk_size
    file_format  = "raw"
  }

  network_device {
    bridge = each.value.bridge
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

# Génération dynamique de l'inventaire Ansible
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  content = templatefile("${path.module}/inventory.tftpl", {
    vms = var.vms
  })
}
