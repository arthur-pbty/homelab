terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.50.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.pm_endpoint
  api_token = "${var.pm_api_token}=${var.pm_api_secret}"
  insecure  = var.pm_insecure
}
