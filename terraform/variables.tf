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

# --- VM 1 : Network ---
variable "vm_network_ip" {
  description = "IP de la VM Network (format CIDR)"
  type        = string
  default     = "192.168.1.11/24"
}

# --- VM 2 : Media ---
variable "vm_media_ip" {
  description = "IP de la VM Media (format CIDR)"
  type        = string
  default     = "192.168.1.12/24"
}

# --- VM 3 : Apps ---
variable "vm_apps_ip" {
  description = "IP de la VM Apps (format CIDR)"
  type        = string
  default     = "192.168.1.13/24"
}
