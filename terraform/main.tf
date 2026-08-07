terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.50.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.pm_endpoint
  api_token = "${var.pm_api_token}=${var.pm_api_secret}"
  insecure  = true
}

# --- VM de Test : Tout en un ---
resource "proxmox_virtual_environment_vm" "test_vm" {
  name        = "srv-test"
  node_name   = var.target_node
  vm_id       = 101
  description = "VM de test"

  clone {
    vm_id = var.debian_template_id
  }

  cpu {
    cores = 2
    type  = "host"
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 20
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
        address = "192.168.1.11/24"
        gateway = "192.168.1.1"
      }
    }
  }
}
