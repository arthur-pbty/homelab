# --- VM 1 : Net & Proxy ---
resource "proxmox_virtual_environment_vm" "network" {
  name        = "srv-network"
  node_name   = var.target_node
  vm_id       = 101
  description = "Traefik, Pihole, Unbound"

  clone {
    vm_id = var.debian_template_id
  }

  cpu {
    cores = 3
    type  = "host"
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 1024
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 10
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
        address = var.vm_network_ip
        gateway = var.gateway
      }
    }
  }
}

# --- VM 2 : Media & Fichiers ---
resource "proxmox_virtual_environment_vm" "media" {
  name        = "srv-media"
  node_name   = var.target_node
  vm_id       = 102
  description = "Immich, Jellyfin, Navidrome, Gokapi"

  clone {
    vm_id = var.debian_template_id
  }

  cpu {
    cores = 3
    type  = "host"
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 1024
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
        address = var.vm_media_ip
        gateway = var.gateway
      }
    }
  }
}

# --- VM 3 : Apps, Dev & Gaming ---
resource "proxmox_virtual_environment_vm" "apps" {
  name        = "srv-apps"
  node_name   = var.target_node
  vm_id       = 103
  description = "Gitea, CI/CD, Searxng, Radicale, Joplin, Shlink, Speedtest, Uptime-Kuma, Crafty"

  clone {
    vm_id = var.debian_template_id
  }

  cpu {
    cores = 3
    type  = "host"
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 1024
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
        address = var.vm_apps_ip
        gateway = var.gateway
      }
    }
  }
}
