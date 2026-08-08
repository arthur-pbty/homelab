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

# --- Configuration des VMs ---
variable "vms" {
  description = "Configuration des différentes VMs à déployer"
  type = map(object({
    vm_id       = number
    name        = string
    description = string
    ip_address  = string
    # Les champs suivants sont optionnels et ont des valeurs par défaut
    cores       = optional(number, 2)
    memory      = optional(number, 2048)
    disk_size   = optional(number, 20)
    datastore   = optional(string, "local-lvm")
    bridge      = optional(string, "vmbr0")
    tags        = optional(list(string), ["homelab"])
  }))

  # Validation : on s'assure que l'IP contient bien un masque CIDR (ex: /24)
  validation {
    condition     = alltrue([for k, v in var.vms : can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", v.ip_address))])
    error_message = "L'adresse IP de chaque VM doit être au format CIDR (ex: 192.168.1.10/24)."
  }
}