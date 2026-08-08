# --- Proxmox ---
variable "pm_endpoint" {
  description = "URL de l'API Proxmox"
  type        = string
}

variable "pm_api_token" {
  description = "ID du token API Proxmox"
  type        = string
  sensitive   = true
}

variable "pm_api_secret" {
  description = "Secret du token API Proxmox"
  type        = string
  sensitive   = true
}

variable "pm_insecure" {
  description = "Désactiver la vérification TLS"
  type        = bool
  default     = true
}

variable "target_node" {
  description = "Nom du noeud Proxmox cible"
  type        = string
}

variable "debian_template_id" {
  description = "ID du template Proxmox à cloner"
  type        = number
}

variable "ssh_public_key" {
  description = "Clé publique SSH à injecter dans les VMs"
  type        = string
}

variable "gateway" {
  description = "Passerelle par défaut du réseau"
  type        = string
  default     = "192.168.1.1"
}

# --- Configuration des VMs (Boucle for_each) ---
variable "vms" {
  description = "Configuration des différentes VMs à déployer"
  type = map(object({
    vm_id       = number
    name        = string
    description = string
    ip_address  = string
    cores       = number
    memory      = number
    disk_size   = number
  }))
}
